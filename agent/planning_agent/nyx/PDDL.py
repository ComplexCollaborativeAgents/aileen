#!/usr/bin/env python
# Four spaces as indentation [no tabs]

import itertools
import re
import sys
import copy

from compiler import JIT
from compiler.preconditions_tree import PreconditionsTree
from syntax.action import Action
from syntax.event import Event
from syntax.process import Process
from syntax.state import State
import syntax.constants as constants


class PDDLDomain:

    def __init__(self, **kwargs):
        self.name = kwargs.get('name', None)
        self.requirements = kwargs.get('requirements', None)
        self.types = kwargs.get('types', dict())
        self.predicates = kwargs.get('predicates', dict())
        self.functions = kwargs.get('functions', dict())
        self.constants = kwargs.get('constants', dict())
        self.processes = kwargs.get('processes', list())
        self.actions = kwargs.get('actions', list())
        self.events = kwargs.get('events', list())


class PDDLProblem:

    def __init__(self, **kwargs):
        self.name = kwargs.get('name', None)
        self.init = kwargs.get('init', None)
        self.objects = kwargs.get('objects', dict())
        self.goals = kwargs.get('goals', list())
        self.metric = kwargs.get('metric', None)


class GroundedPDDLInstance:

    def __init__(self, domain: PDDLDomain, problem: PDDLProblem):
        self.domain = domain
        self.problem = problem

        self.enact_requirements()
        self._objects = None
        self._initialize_state()
        self._goals_code, self.goals = JIT.compile_expression(self.problem.goals, name='goals')
        if self.problem.metric != ['total-time'] and self.problem.metric != ['total-actions'] and self.problem.metric is not None:
            self._metric_code, self.metric = JIT.compile_expression([self.problem.metric], name='metric')
        self.processes = self._groundify_happenings(self.domain.processes)
        self.events = self._groundify_happenings(self.domain.events)
        self.actions = self._groundify_happenings(self.domain.actions)
        self._duration_constraints_code, self.duration_constraints = JIT.compile_expression(self._translate_duration_constraints(), name='durative_constraints')
        if constants.TEMPORAL_DOMAIN:
            if constants.PRECONDITION_TREE:
                self.actions.add_happening(constants.TIME_PASSING_ACTION)
            else:
                self.actions.insert(0, constants.TIME_PASSING_ACTION)

    def _translate_duration_constraints(self):

        duration_constraints = []
        snap_end_actions_preconditions = []
        durative_process_invariants = []

        action_list = self.actions
        process_list = self.processes
        if constants.PRECONDITION_TREE:
            action_list = self.actions.iter()
            process_list = self.processes.iter()

        ## collect action duration constraints
        for ga in action_list:
            if ga.happening_type == "snap_end":
                for gap in ga.preconditions:
                    snap_end_actions_preconditions.append(gap)



        for pre in snap_end_actions_preconditions:
            if pre[0] in ['=', '>', '>=', '<', '<='] and ('process_clock' in pre[1] or 'process_clock' in pre[1][0]):
                # translate a numeric duration precondition into a constraint
                if pre[0] == '=':
                    copy_pre = copy.copy(pre)
                    copy_pre[0] = '<='
                    duration_constraints.append(copy_pre)
                elif pre[0] == '<' or pre[0] == '<=':
                    duration_constraints.append(copy.copy(pre))
                continue

        ## collect durative process invariants
        for gp in process_list:
            if gp.happening_type == "durative_action_process":
                formatted_invariant = ['or'] + ([['not'] + [i for i in gp.preconditions if '{}_process_clock_activated'.format(gp.name.replace('_durative_process','')) in i]]) + [['and'] + gp.preconditions]
                duration_constraints.append(formatted_invariant)

        return duration_constraints

    def enact_requirements(self):
        for requirement in self.domain.requirements:
            if requirement == ':time':
                constants.TEMPORAL_DOMAIN = True

    @property
    def objects(self) -> dict:
        if self._objects is None:
            self._objects = dict()
            for obj_source in [self.domain.constants, self.problem.objects]:
                for type_name, obj_list in obj_source.items():
                    if type_name not in self._objects:
                        self._objects[type_name] = []
                    self._objects[type_name].extend((obj for obj in obj_list if obj not in self._objects[type_name]))
        return self._objects

    @staticmethod
    def _groundify(variables: dict, objects: dict):
        grounded_vars = []
        for var_name, type_pairs in variables.items():
            grounded_type_instances = [objects[type_name] for _, type_name in type_pairs.items()]
            for almost_grounded in itertools.product(*grounded_type_instances):
                grounded_vars.append([var_name] + list(almost_grounded))
        return grounded_vars

    def _initialize_state(self):
        state_variables = {}
        for grounded_predicate in self._groundify(self.domain.predicates, self.objects):
            state_variables[str(grounded_predicate)] = False
        for grounded_function in self._groundify(self.domain.functions, self.objects):
            state_variables[str(grounded_function)] = 0.0
        self.init_state = State(state_vars=state_variables)
        self.init_state.instantiate(self.problem.init)

    def _groundify_happenings(self, happenings): # -> PreconditionsTree:

        if constants.PRECONDITION_TREE:
            preconditions_tree = PreconditionsTree()
            for happening in happenings:
                for grounded_happening in happening.groundify(self.objects, self.domain.types):
                    preconditions_tree.add_happening(grounded_happening)
            return preconditions_tree

        else: 
            grounded_happenings = []
            for happening in happenings:
                grounded_happenings.extend(happening.groundify(self.objects, self.domain.types))
            return grounded_happenings


class PDDL_Parser:

    SUPPORTED_REQUIREMENTS = [':strips', ':adl', ':negative-preconditions', ':typing', ':time', ':fluents', ':timed-initial-literals', ':durative-actions', ':duration-inequalities', ':continuous-effects', ':disjunctive-preconditions', ':semantic-attachment']

    def __init__(self, domain_file, problem_file):
        self.domain = PDDLDomain()
        self.problem = PDDLProblem()
        self.parse_domain(domain_file)
        self.parse_problem(problem_file)
        self.grounded_instance = GroundedPDDLInstance(self.domain, self.problem)

    #-----------------------------------------------
    # Tokens
    #-----------------------------------------------

    def scan_tokens(self, filename):
        with open(filename,'r') as f:
            # Remove single line comments
            str = re.sub(r';.*$', '', f.read(), flags=re.MULTILINE).lower()
        # Tokenize
        stack = []
        list = []
        for t in re.findall(r'[()]|[^\s()]+', str):
            if t == '(':
                stack.append(list)
                list = []
            elif t == ')':
                if stack:
                    l = list
                    list = stack.pop()
                    list.append(l)
                else:
                    raise Exception('Missing open parentheses')
            else:
                list.append(t)
        if stack:
            raise Exception('Missing close parentheses')
        if len(list) != 1:
            raise Exception('Malformed expression')
        return list[0]

    #-----------------------------------------------
    # Parse domain
    #-----------------------------------------------

    def parse_domain(self, domain_filename):

        try: 
            tokens = self.scan_tokens(domain_filename)
        except Exception as dom_error:
            print("PDDL domain file error: missing file or malformed domain definition. \nRun \'python nyx.py -h\' for help and usage instructions.\n")
            # print(constants.HELP_TEXT)
            sys.exit(1)

        if type(tokens) is list and tokens.pop(0) == 'define':
            self.domain.name = 'unknown'
            while tokens:
                group = tokens.pop(0)
                t = group.pop(0)
                if t == 'domain':
                    self.domain.name = group[0]
                elif t == ':requirements':
                    for req in group:
                        if req == ':time':
                            constants.TEMPORAL_DOMAIN = True
                        if req == ':semantic-attachment':
                            constants.SEMANTIC_ATTACHMENT = True
                        if not req in self.SUPPORTED_REQUIREMENTS:
                            raise Exception('Requirement ' + req + ' not supported')
                        if req == ':timed-initial-literals' or req == ':timed-initial-fluents':
                            constants.CONTAINS_TIL_TIF = True
                    self.domain.requirements = group
                elif t == ':constants':
                    self.parse_constants(group, t)
                elif t == ':predicates':
                    self.parse_predicates(group)
                elif t == ':functions':
                    self.parse_functions(group)
                elif t == ':types':
                    self.parse_types(group)
                elif t == ':action':
                    self.parse_action(group)
                elif t == ':durative-action':
                    constants.TEMPORAL_DOMAIN = True
                    self.parse_durative_action(group)
                elif t == ':event':
                    self.parse_event(group)
                elif t == ':process':
                    self.parse_process(group)
                else: self.parse_domain_extended(t, group)
        else:
            raise Exception('File ' + domain_filename + ' does not match domain pattern')

    def parse_domain_extended(self, t, group):
        print(str(t) + ' is not recognized in domain')

    #-----------------------------------------------
    # Parse hierarchy
    #-----------------------------------------------

    def parse_hierarchy(self, group, structure, name, redefine):
        list = []
        while group:
            if redefine and group[0] in structure:
                raise Exception('Redefined supertype of ' + group[0])
            elif group[0] == '-':
                if not list:
                    raise Exception('Unexpected hyphen in ' + name)
                group.pop(0)
                type = group.pop(0)
                if not type in structure:
                    structure[type] = []
                structure[type] += list
                list = []
            else:
                list.append(group.pop(0))
        if list:
            if not 'object' in structure:
                structure['object'] = []
            structure['object'] += list

    #-----------------------------------------------
    # Parse constants
    #-----------------------------------------------

    def parse_constants(self, group, name):
        self.parse_hierarchy(group, self.domain.constants, name, False)

    #-----------------------------------------------
    # Parse objects
    #-----------------------------------------------

    def parse_objects(self, group, name):
        self.parse_hierarchy(group, self.problem.objects, name, False)

    # -----------------------------------------------
    # Parse types
    # -----------------------------------------------

    def parse_types(self, group):
        self.parse_hierarchy(group, self.domain.types, 'types', True)

    #-----------------------------------------------
    # Parse predicates
    #-----------------------------------------------

    def parse_predicates(self, group):
        for pred in group:
            predicate_name = pred.pop(0)
            if predicate_name in self.domain.predicates:
                raise Exception('Predicate ' + predicate_name + ' redefined')
            arguments = {}
            untyped_variables = []
            while pred:
                t = pred.pop(0)
                if t == '-':
                    if not untyped_variables:
                        raise Exception('Unexpected hyphen in predicates')
                    type = pred.pop(0)
                    while untyped_variables:
                        arguments[untyped_variables.pop(0)] = type
                else:
                    untyped_variables.append(t)
            while untyped_variables:
                arguments[untyped_variables.pop(0)] = 'object'
            self.domain.predicates[predicate_name] = arguments

    # -----------------------------------------------
    # Parse functions
    # -----------------------------------------------

    def parse_functions(self, group):
        for func in group:
            function_name = func.pop(0)
            if function_name in self.domain.functions:
                raise Exception('Function ' + function_name + ' redefined')
            arguments = {}
            untyped_variables = []
            while func:
                t = func.pop(0)
                if t == '-':
                    if not untyped_variables:
                        raise Exception('Unexpected hyphen in functions')
                    type = func.pop(0)
                    while untyped_variables:
                        arguments[untyped_variables.pop(0)] = type
                else:
                    untyped_variables.append(t)
            while untyped_variables:
                arguments[untyped_variables.pop(0)] = 'object'
            self.domain.functions[function_name] = arguments

    #-----------------------------------------------
    # Parse action
    #-----------------------------------------------

    def parse_action(self, group):
        name = group.pop(0)
        if not type(name) is str:
            raise Exception('Action without name definition')
        for act in self.domain.actions:
            if act.name == name:
                raise Exception('Action ' + name + ' redefined')
        parameters = []
        preconditions = []
        effects = []
        extensions = None
        while group:
            t = group.pop(0)
            if t == ':parameters':
                if not type(group) is list:
                    raise Exception('Error with ' + name + ' parameters')
                parameters = []
                untyped_parameters = []
                p = group.pop(0)
                while p:
                    t = p.pop(0)
                    if t == '-':
                        if not untyped_parameters:
                            raise Exception('Unexpected hyphen in ' + name + ' parameters')
                        ptype = p.pop(0)
                        while untyped_parameters:
                            parameters.append([untyped_parameters.pop(0), ptype])
                    else:
                        untyped_parameters.append(t)
                while untyped_parameters:
                    parameters.append([untyped_parameters.pop(0), 'object'])
            elif t == ':precondition':
                # preconditions = group.pop(0)
                self.split_predicates(group.pop(0), preconditions, name, ' preconditions')
            elif t == ':effect':
                # effects = group.pop(0)
                self.split_predicates(group.pop(0), effects, name, ' effects')
            else: extensions = self.parse_action_extended(t, group)
        self.domain.actions.append(Action(name, parameters, preconditions, effects))

    def parse_action_extended(self, t, group):
        print(str(t) + ' is not recognized in action')

    # -----------------------------------------------
    # Parse durative-action
    # -----------------------------------------------

    def parse_durative_action(self, group):
        name = group.pop(0)
        if not type(name) is str:
            raise Exception('Durative-Action without name definition')
        for act in self.domain.actions:
            if act.name == name:
                raise Exception('Durative-Action ' + name + ' redefined')
        parameters_start = []
        parameters_process = []
        parameters_end = []
        preconditions_start = []
        preconditions_process = []
        preconditions_end = []
        effects_start = []
        effects_process = []
        effects_end = []
        extensions = None
        while group:
            t = group.pop(0)
            if t == ':parameters':
                if not type(group) is list:
                    raise Exception('Error with ' + name + ' parameters')
                parameters = []
                untyped_parameters = []
                p = group.pop(0)
                while p:
                    t = p.pop(0)
                    if t == '-':
                        if not untyped_parameters:
                            raise Exception('Unexpected hyphen in ' + name + ' parameters')
                        ptype = p.pop(0)
                        while untyped_parameters:
                            parameters.append([untyped_parameters.pop(0), ptype])
                    else:
                        untyped_parameters.append(t)
                while untyped_parameters:
                    parameters.append([untyped_parameters.pop(0), 'object'])
            elif t == ':duration':
                duration_condition = group.pop(0)

                # generate auxiliary timing variables + add them to domain definition
                expanded_params = []
                for param_and_type in parameters:
                        expanded_params = expanded_params + [param_and_type[0],'-',param_and_type[1]]
                aux_clock_activated_predicate = ['{}_process_clock_activated'.format(name)] + [item[0] for item in parameters]
                self.parse_predicates([['{}_process_clock_activated'.format(name)] + expanded_params])
                aux_clock_numeric = ['{}_process_clock'.format(name)] + [item[0] for item in parameters]
                self.parse_functions([['{}_process_clock'.format(name)] + expanded_params])

                aux_end_clock_reset = ['assign', aux_clock_numeric, '0.0']
                aux_start_clock_activate = aux_clock_activated_predicate
                aux_end_clock_deactivate = ['not', aux_clock_activated_predicate]

                #
                duration_condition[duration_condition.index('?duration')] =  aux_clock_numeric
                self.split_predicates(duration_condition, preconditions_end, name, ' preconditions')

                # increase durative-action process clock with each time tick
                aux_process_clock_effect = ['increase' , aux_clock_numeric, ['*', '#t', '1.0']]
                self.split_predicates(aux_start_clock_activate, preconditions_process, name, ' preconditions')
                self.split_predicates(aux_process_clock_effect, effects_process, name, ' effects')

                # deactivate and reset durative-action process clock from end snap action (+ process activated precondition)
                self.split_predicates(aux_start_clock_activate, preconditions_end, name, ' preconditions')
                self.split_predicates(aux_end_clock_deactivate, effects_end, name, ' effects')
                self.split_predicates(aux_end_clock_reset, effects_end, name, ' effects')

                # activate durative-action process from start snap action (and precondition to prevent re-starting an already-running instance).

                self.split_predicates(aux_start_clock_activate, effects_start, name, ' effects')
                self.split_predicates(aux_end_clock_deactivate, preconditions_start, name, ' preconditions')

            elif t == ':condition':
                # preconditions = group.pop(0)
                self.split_durative_predicates(group.pop(0), [preconditions_start, preconditions_process, preconditions_end], name, ' preconditions')
            elif t == ':effect':
                # effects = group.pop(0)
                self.split_durative_predicates(group.pop(0), [effects_start, effects_process, effects_end], name, ' effects')
            else:
                extensions = self.parse_action_extended(t, group)

        ###
        #   PARSE and PROCESS DURATION INFORMATION:
        #       timing process, at_end timing_process precondition, at_end timing reset, ...
        #
        #   - Investigate whether durative-actions must be ended for a plan to be valid.
        ###


        self.domain.actions.append(Action(name+"_durative_start", parameters, preconditions_start, effects_start, happening_type="snap_start"))
        self.domain.processes.append(Process(name+"_durative_process", parameters, preconditions_process, effects_process, happening_type="durative_action_process"))
        self.domain.actions.append(Action(name+"_durative_end", parameters, preconditions_end, effects_end, happening_type="snap_end"))

    def parse_durative_action_extended(self, t, group):
        print(str(t) + ' is not recognized in durative-action')

    # -----------------------------------------------
    # Parse event
    # -----------------------------------------------

    def parse_event(self, group):
        name = group.pop(0)
        if not type(name) is str:
            raise Exception('Event without name definition')
        for eve in self.domain.events:
            if eve.name == name:
                raise Exception('Event ' + name + ' redefined')
        parameters = []
        preconditions = []
        effects = []
        extensions = None
        while group:
            t = group.pop(0)
            if t == ':parameters':
                if not type(group) is list:
                    raise Exception('Error with ' + name + ' parameters')
                parameters = []
                untyped_parameters = []
                p = group.pop(0)
                while p:
                    t = p.pop(0)
                    if t == '-':
                        if not untyped_parameters:
                            raise Exception('Unexpected hyphen in ' + name + ' parameters')
                        ptype = p.pop(0)
                        while untyped_parameters:
                            parameters.append([untyped_parameters.pop(0), ptype])
                    else:
                        untyped_parameters.append(t)
                while untyped_parameters:
                    parameters.append([untyped_parameters.pop(0), 'object'])
            elif t == ':precondition':
                self.split_predicates(group.pop(0), preconditions, name, ' preconditions')
            elif t == ':effect':
                self.split_predicates(group.pop(0), effects, name, ' effects')
            else:
                extensions = self.parse_event_extended(t, group)
        self.domain.events.append(Event(name, parameters, preconditions, effects, extensions))

    def parse_event_extended(self, t, group):
        print(str(t) + ' is not recognized in event')

    # -----------------------------------------------
    # Parse process
    # -----------------------------------------------

    def parse_process(self, group):
        name = group.pop(0)
        if not type(name) is str:
            raise Exception('Process without name definition')
        for pro in self.domain.processes:
            if pro.name == name:
                raise Exception('Process ' + name + ' redefined')
        parameters = []
        preconditions = []
        effects = []
        extensions = None
        while group:
            t = group.pop(0)
            if t == ':parameters':
                if not type(group) is list:
                    raise Exception('Error with ' + name + ' parameters')
                parameters = []
                untyped_parameters = []
                p = group.pop(0)
                while p:
                    t = p.pop(0)
                    if t == '-':
                        if not untyped_parameters:
                            raise Exception('Unexpected hyphen in ' + name + ' parameters')
                        ptype = p.pop(0)
                        while untyped_parameters:
                            parameters.append([untyped_parameters.pop(0), ptype])
                    else:
                        untyped_parameters.append(t)
                while untyped_parameters:
                    parameters.append([untyped_parameters.pop(0), 'object'])
            elif t == ':precondition':
                self.split_predicates(group.pop(0), preconditions, name, ' preconditions')
            elif t == ':effect':
                self.split_predicates(group.pop(0), effects, name, ' effects')
            else:
                extensions = self.parse_process_extended(t, group)
        self.domain.processes.append(Process(name, parameters, preconditions, effects, extensions))

    def parse_process_extended(self, t, group):
        print(str(t) + ' is not recognized in process')

    #-----------------------------------------------
    # Parse problem
    #-----------------------------------------------

    def parse_problem(self, problem_filename):
        def frozenset_of_tuples(data):
            return frozenset([tuple(t) for t in data])

        try:
            tokens = self.scan_tokens(problem_filename)
        except Exception as prob_error:
            print("PDDL problem file error: missing file or malformed problem definition. \nRun \'python nyx.py -h\' for help and usage instructions.\n")
            # print(constants.HELP_TEXT)
            sys.exit(1)

        if type(tokens) is list and tokens.pop(0) == 'define':
            self.problem.name = 'unknown'
            while tokens:
                group = tokens.pop(0)
                t = group.pop(0)
                if t == 'problem':
                    self.problem.name = group[0]
                elif t == ':domain':
                    if self.domain.name != group[0]:
                        raise Exception('Different domain specified in problem file')
                elif t == ':requirements':
                    pass # Ignore requirements in problem, parse them in the domain
                elif t == ':objects':
                    self.parse_objects(group, t)
                elif t == ':init':
                    self.problem.init = copy.copy(group)
                    if (constants.CONTAINS_TIL_TIF):
                        til_index = 0
                        for init_var in group:
                            if init_var[0] == 'at' and len(init_var)==3:
                                # construct a time-based event for the TIL/TIF
                                self.parse_predicates([['TIL_{}_triggered'.format(til_index)]])
                                # self.parse_event(['TIL_{}'.format(til_index), ':parameters', [], ':precondition', ['and', ['not',['TIL_{}_triggered'.format(til_index)]], ['>=', 'state.time', init_var[1]]], ':effect', ['and', ['TIL_{}_triggered'.format(til_index)], init_var[2]]])
                                self.domain.events.insert(0, Event('TIL_{}'.format(til_index), [], [['not',['TIL_{}_triggered'.format(til_index)]],['>=', 'state.time', init_var[1]]], [['TIL_{}_triggered'.format(til_index)], init_var[2]], happening_type="timed_initial_event"))
                                til_index += 1
                                self.problem.init.remove(init_var)
                elif t == ':goal':
                    goals = []
                    self.split_predicates(group[0], goals, '', 'goals')
                    self.problem.goals = goals
                elif t == ':metric':
                    min_max_label = group.pop(0)
                    constants.METRIC_MINIMIZE = False if min_max_label == 'maximize' else True
                    self.problem.metric = group.pop(0)
                else: self.parse_problem_extended(t, group)
        else:
            raise Exception('File ' + problem_filename + ' does not match problem pattern')

    def parse_problem_extended(self, t, group):
        print(str(t) + ' is not recognized in problem')

    #-----------------------------------------------
    # Split predicates
    #-----------------------------------------------

    def split_predicates(self, group, preds, name, part):
        if not type(group) is list:
            raise Exception('Error with ' + name + part)
        if group == []:
            # takes care of empty preconditions
            return
        if group[0] == 'and':
            group.pop(0)
        else:
            group = [group]
        for predicate in group:
            if predicate[0] == 'not':
                if len(predicate) != 2:
                    raise Exception('Unexpected not in ' + name + part)
                preds.append(predicate)
            else:
                preds.append(predicate)

    # -----------------------------------------------
    # Split predicates of durative actions
    # -----------------------------------------------

    def split_durative_predicates(self, group, preds, name, part):
        if not type(group) is list:
            raise Exception('Error with ' + name + part)
        if group[0] == 'and':
            group.pop(0)
        else:
            group = [group]
        for predicate in group:
            relevant_preds = preds[1]
            if predicate[0] == 'at' and predicate[1] == 'start':
                relevant_preds = preds[0]
                predicate = predicate[2]
            elif predicate[0] == 'at' and predicate[1] == 'end':
                relevant_preds = preds[2]
                predicate = predicate[2]
            elif predicate[0] == 'over' and predicate[1] == 'all':
                relevant_preds = preds[1]
                predicate = predicate[2]
            elif predicate[0] == 'increase' or predicate[0] == 'decrease':
                relevant_preds = preds[1]
            else:
                raise Exception('malformed durative-action! no temporal annotation in happening \'{}\' for {}: {}'.format(name, part, predicate))
            if predicate[0] == 'not':
                if len(predicate) != 2:
                    raise Exception('Unexpected not in ' + name + part)
                relevant_preds.append(predicate)
            else:
                relevant_preds.append(predicate)

#-----------------------------------------------
# Main
#-----------------------------------------------
if __name__ == '__main__':
    import sys, pprint
    # domain = sys.argv[1]
    domain = "ex/lg_process/generator.pddl"
    # problem = sys.argv[2]
    problem = "ex/lg_process/pb01.pddl"
    parser = PDDL_Parser(domain, problem)
    print('----------------------------')
    print('Domain name: ' + parser.domain.name)
    pprint.pprint(parser.domain.predicates)
    pprint.pprint(parser.domain.functions)
    for act in parser.domain.actions:
        print(act)
    for eve in parser.domain.events:
        print(eve)
    for pro in parser.domain.processes:
        print(pro)
    print('----------------------------')
    print('Problem name: ' + parser.problem.name)
    print('Objects: ' + str(parser.grounded_instance.objects))
    print('Types: ' + str(parser.domain.types))
    print('Init State:')
    pprint.pprint(parser.problem.init)
    print('Goals:')
    pprint.pprint(parser.problem.goals)
    print('----------------------------')
    print('Grounded Happenings:')
    for act in parser.grounded_instance.actions:
        print(act)
    for eve in parser.grounded_instance.events:
        print(eve)
    for pro in parser.grounded_instance.processes:
        print(pro)
