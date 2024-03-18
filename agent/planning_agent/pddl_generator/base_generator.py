from typing import List, Dict, Union
from os import path

ROOT_PATH = path.join(path.dirname(path.dirname(path.dirname(path.dirname(path.abspath(__file__))))))

class BaseGenerator():
    def __init__(self, _path: str, name :str):
        self.path = path.join(ROOT_PATH, _path)
        self.name = name

    def generate(self, **kwargs):
        raise NotImplementedError()


class PDDLDomain:
    TEMPLATE = "(define (domain {NAME})\n(:requirements\n{REQUIREMENTS})\n(:types\n{TYPES}\n)\n(:predicates\n{PREDICATES}\n)\n(:functions\n{FUNCTIONS}\n)\n{ACTIONS}\n{PROCESSES}\n{EVENTS}\n)"
    
    def __init__(self, name):
        self.name = name
        self.requirements = list()
        self.separator = "\n\n"
        self.state_separator = "\n"
        self.predicates = list()
        self.functions = list()
        self.types = dict()
        self.actions = list()
        self.processes = list()
        self.events = list()

    def set_requirements(self, requirements):
        self.requirements = requirements

    def get_requirements(self):
        return self.requirements

    def set_predicates(self, predicates):
        self.predicates = predicates


    def get_predicates(self):
        return self.predicates


    def set_functions(self, functions):
        self.functions = functions


    def get_functions(self):
        return self.functions


    def set_types(self, _types: Dict):
        self.types = dict()


    def get_types(self):
        return self.types


    def get_types_string(self):
        _types = self.get_types()
        types_string = ""
        for parent, children in _types.items():
            child_string = children
            if isinstance(children, list):
                child_string = " ".join(children)

            types_string += f"{child_string} - {parent}\n"

        return types_string.strip()

    def set_actions(self, actions:list):
        self.actions = actions


    def get_actions(self):
        return self.actions


    def set_processes(self, processes: list):
        self.processes = processes


    def get_processes(self):
        return self.processes


    def set_events(self, events: list):
        self.events = events


    def get_events(self):
        return self.events


    def write_to_file(self, file_name):
        domain = PDDLDomain.TEMPLATE.format(
            NAME=self.name,
            REQUIREMENTS=self.state_separator.join(self.get_requirements()),
            TYPES=self.get_types_string(),
            PREDICATES=self.state_separator.join([str(p) for p in self.get_predicates()]),
            FUNCTIONS=self.state_separator.join([str(f) for f in self.get_functions()]),
            ACTIONS=self.separator.join([act.to_pddl() for act in self.get_actions()]),
            PROCESSES=self.separator.join(self.get_processes()),
            EVENTS=self.separator.join(self.get_events())
        )

        with open(file_name, "w") as f:
            f.write(domain)


class PDDLProblem():
    TEMPLATE = "(define (problem {PROBLEM_NAME})\n(domain {DOMAIN_NAME})\n(:objects\n{OBJECTS})\n(:init\n{INITIAL_STATE})\n(:goal (and\n{GOAL_CONDITION}\n)\n)\n)"


    def __init__(self, problem_name:str, domain_name:str):
        self.separator = "\n\t"
        self.domain_name = domain_name
        self.problem_name = problem_name
        self.objects = dict()
        self.initial = list()
        self.goal = ""

    def set_objects(self, objs: Dict[str, List[str]]):
        self.objects = objs


    def get_objects(self):
        return self.objects


    def get_objects_string(self):
        objects = self.get_objects()
        obj_type_string = ""
        for _type, objs in objects.items():
            obj_string = " ".join(objs)
            obj_type_string += f"\n{obj_string} - {_type}"

        return obj_type_string

    def set_initial_state(self, state: List[str]):
        self.initial = state


    def get_initial_state(self):
        return self.initial


    def set_goal(self, condition: List[str]):
        self.goal = condition


    def get_goal(self):
        return self.goal


    def write_to_file(self, file_name):
        problem = PDDLProblem.TEMPLATE.format(
            PROBLEM_NAME=self.problem_name,
            DOMAIN_NAME=self.domain_name,
            OBJECTS=self.get_objects_string(),
            INITIAL_STATE=self.separator.join([str(p) for p in self.get_initial_state()]),
            GOAL_CONDITION=self.get_goal()
        )

        with open(file_name, "w") as f:
            f.write(problem)

