#!/usr/bin/env python
# Four spaces as indentation [no tabs]
import bisect
import collections
from hmac import new

import heuristic_functions as heuristic_functions
from PDDL import PDDL_Parser
import syntax.constants as constants
import time, copy, sys
from syntax.visited_state import VisitedState
from syntax.state import State

import semantic_attachments.semantic_attachment as semantic_attachment

class Planner:

    #-----------------------------------------------
    # Solve
    #-----------------------------------------------

    # initial_state = None
    # reached_goal_state = None
    # explored_states = 0
    # # total_visited = 0
    # queue = []
    # visited_hashmap = {}

    def __init__(self):
        self.initial_state = None
        self.reached_goal_states = collections.deque(maxlen=constants.TRACKED_PLANS)
        self.explored_states = 0
        # self.total_visited = 0
        self.queue = collections.deque()
        self.visited_hashmap = {}
        self.total_goals_found = 0


    def solve(self, domain, problem):

        start_solve_time = time.time()
        # Parser
        parser = PDDL_Parser(domain, problem)
        grounded_instance = parser.grounded_instance
        # Parsed data
        state = grounded_instance.init_state
        self.initial_state = grounded_instance.init_state

        print("\t* model parse time: " + str("{:5.4f}".format(time.time() - start_solve_time)) + "s")
        print('\n=================================================\n\n\n\n\n\n\n')
        # Do nothing
        if grounded_instance.goals(state, constants):
            return []

        # Search
        self.visited_hashmap[hash(VisitedState(state))] = VisitedState(state)
        self.queue = collections.deque([state])
        while self.queue:
            state = self.queue.popleft()

            if grounded_instance.goals(state, constants):
                self.total_goals_found += 1
                if grounded_instance.problem.metric == ['total-time']:
                    state.metric = state.time
                elif grounded_instance.problem.metric == ['total-actions'] or grounded_instance.problem.metric == None:
                    state.metric = state.depth
                else:
                    state.metric = grounded_instance.metric(state, constants)
                self.enqueue_goal(VisitedState(state))
                if not (constants.ANYTIME):
                    return self.reached_goal_states

            if VisitedState(state) in self.reached_goal_states:
                # print("already in goals list")
                # print(state)
                continue

            from_state = VisitedState(state)
            # time_passed = round(state.time + constants.DELTA_T, constants.NUMBER_PRECISION)

            # for aa in grounded_instance.actions.get_applicable(state):
            for aa in state.get_applicable_happenings(grounded_instance.actions):

                
                new_state = None

                if aa == constants.TIME_PASSING_ACTION:

                    ### HAPPENINGS ORDER: (events - optional if -dblevent) -> semantic attachment -> processes -> TILs -> events -> actions

                    # new_state = copy.deepcopy(state)
                    new_state = State(t=state.time, g=state.g + 1, predecessor=state, predecessor_action=aa)

                    # first check for triggered events if '-dblevent' flag is true
                    if constants.DOUBLE_EVENT_CHECK:
                        # happenings_list = grounded_instance.events.get_applicable(new_state)
                        happenings_list = new_state.get_applicable_happenings(grounded_instance.events)
                        for hp_e1 in happenings_list:
                            new_state = new_state.apply_happening(hp_e1, from_state=from_state, create_new_state=new_state is state)

                    # check whether any semantic attachment processes are active, if applicable
                    if constants.SEMANTIC_ATTACHMENT:
                        if new_state is state:
                            ### TODO: CHECK IF THIS CONDITIONAL BLOCK IS NECESSARY
                            new_state = State(t=state.time, g=state.g + 1, predecessor=state, predecessor_action=aa)
                        new_state = semantic_attachment.external_function(new_state)

                    # next check applicable processes
                    # happenings_list = grounded_instance.processes.get_applicable(new_state)
                    happenings_list = new_state.get_applicable_happenings(grounded_instance.processes)
                    for hp_p1 in happenings_list:
                        new_state = new_state.apply_happening(hp_p1, from_state=from_state, create_new_state=new_state is state)

                    # set clock for the newly generated state after applying process effects
                    new_state.time = constants.fast_round(state.time + constants.DELTA_T, constants.NUMBER_PRECISION)
                    # new_state.set_time(time_passed)

                    # check TILs first thing after passing time
                    happenings_list = new_state.get_applicable_happenings(grounded_instance.events)
                    for hp_e_til in happenings_list:
                        if (hp_e_til.happening_type == 'timed_initial_event'):
                            new_state = new_state.apply_happening(hp_e_til, from_state=from_state, create_new_state=new_state is state)

                    # next check triggered events
                    # happenings_list = grounded_instance.events.get_applicable(new_state)
                    happenings_list = new_state.get_applicable_happenings(grounded_instance.events)
                    for hp_e2 in happenings_list:
                        new_state = new_state.apply_happening(hp_e2, from_state=from_state, create_new_state=new_state is state)

                    ### TODO: CHECK IF THIS BLOCK IS NECESSARY
                    # if new_state is state:
                    #     new_state = copy.deepcopy(state)
                    #     new_state.predecessor_hashed = hash(from_state)

                    new_state.predecessor_action = aa

                else:
                    ### HAPPENINGS ORDER (for non-temporal domains): actions -> semantic attachments -> events
                    ### (TODO: CHECK IF THIS IS THE CORRECT ORDER OF HAPPENINGS)


                    new_state = state.apply_happening(aa, from_state=from_state, create_new_state=True)

                    # check events in non-temporal domains, if exist
                    if not constants.TEMPORAL_DOMAIN:

                        # check whether any semantic attachment are present, if applicable
                        if constants.SEMANTIC_ATTACHMENT:
                            new_state = semantic_attachment.external_function(new_state)

                        # happenings_list = grounded_instance.events.get_applicable(new_state)
                        happenings_list = new_state.get_applicable_happenings(grounded_instance.events)
                        for hp_e in happenings_list:
                            new_state = new_state.apply_happening(hp_e, from_state=from_state, create_new_state=new_state is state)

                self.explored_states += 1

                # if not grounded_instance.duration_constraints(state, constants):
                #     print("VIOLATED DURATION CONSTRAINTSSSSSS!")

                new_state_hash = hash(VisitedState(new_state))
                if new_state.time <= constants.TIME_HORIZON and new_state.depth <= constants.DEPTH_LIMIT and grounded_instance.duration_constraints(new_state, constants):
                    
                    if (new_state_hash not in self.visited_hashmap) or \
                        (constants.METRIC_MINIMIZE and new_state.metric < self.visited_hashmap[new_state_hash].state.metric) or \
                            (not constants.METRIC_MINIMIZE and new_state.metric > self.visited_hashmap[new_state_hash].state.metric):
                        self.visited_hashmap[new_state_hash] = VisitedState(new_state)
                        self.enqueue_state(new_state)

                if self.explored_states % constants.PRINT_INFO == 0:
                    print_q = []
                    # visi = len(self.visited_hashmap)
                    time_checkpoint = time.time() - start_solve_time
                    print_q.append('[' + str("{:6.2f}".format(time_checkpoint)) + '] ==> states explored: ' + str(self.explored_states))
                    print_q.append('\t\t ==> exploration rate: ' + str(constants.fast_round(self.explored_states / time_checkpoint, 2)) + ' states/sec')
                    if (constants.ANYTIME):
                        print_q.append('\t\t ==> tracked goals: ' + str(len(self.reached_goal_states)))
                        print_q.append('\t\t ==> total goals found: ' + str(self.total_goals_found))
                        if len(self.reached_goal_states) > 0:
                            print_q.append('\t\t ==> best metric: {:6.3f}'.format(self.reached_goal_states[0].state.metric))
                        else:
                            print_q.append('\t\t ==> best metric: N/A')

                    if (not (constants.PRINT_ALL_STATES)):
                        for _ in range(len(print_q)):
                            sys.stdout.write("\x1b[1A\x1b[2K")  # move up cursor and delete whole line
                    # print_q.append(s)
                    for i in range(len(print_q)):
                        sys.stdout.write(print_q[i] + "\n")  # reprint the lines

            if (time.time() - start_solve_time) >= constants.TIMEOUT:
                if (constants.ANYTIME):
                    return self.reached_goal_states
                return None

        return None


    def solve_pt(self, domain, problem):

        start_solve_time = time.time()
        # Parser
        parser = PDDL_Parser(domain, problem)
        grounded_instance = parser.grounded_instance
        # Parsed data
        state = grounded_instance.init_state
        self.initial_state = grounded_instance.init_state

        print("\t* model parse time: " + str("{:5.4f}".format(time.time() - start_solve_time)) + "s")
        print('\n=================================================\n\n\n\n\n\n')
        # Do nothing
        if grounded_instance.goals(state, constants):
            return []

        # Search
        self.visited_hashmap[hash(VisitedState(state))] = VisitedState(state)
        self.queue = collections.deque([state])
        while self.queue:
            state = self.queue.popleft()

            if grounded_instance.goals(state, constants):
                self.total_goals_found += 1
                if grounded_instance.problem.metric == ['total-time']:
                    state.metric = state.time
                elif grounded_instance.problem.metric == ['total-actions'] or grounded_instance.problem.metric == None:
                    state.metric = state.depth
                else:
                    state.metric = grounded_instance.metric(state, constants)
                self.enqueue_goal(VisitedState(state))
                if not (constants.ANYTIME):
                    return self.reached_goal_states

            if VisitedState(state) in self.reached_goal_states:
                # print("already in goals list")
                # print(state)
                continue

            from_state = VisitedState(state)
            # time_passed = round(state.time + constants.DELTA_T, constants.NUMBER_PRECISION)

            for aa in grounded_instance.actions.get_applicable(state):
                
                new_state = None

                if aa == constants.TIME_PASSING_ACTION:

                    ### HAPPENINGS ORDER: (events - optional if -dblevent) -> semantic attachment -> processes -> TILs -> events -> actions

                    # new_state = copy.deepcopy(state)
                    new_state = State(t=state.time, g=state.g + 1, predecessor=state, predecessor_action=aa)

                    # first check for triggered events if '-dblevent' flag is true
                    if constants.DOUBLE_EVENT_CHECK:
                        happenings_list = grounded_instance.events.get_applicable(new_state)
                        for hp_e1 in happenings_list:
                            new_state = new_state.apply_happening(hp_e1, from_state=from_state, create_new_state=new_state is state)

                    # check whether any semantic attachment processes are active, if applicable
                    if constants.SEMANTIC_ATTACHMENT:
                        if new_state is state:
                            ### TODO: CHECK IF THIS CONDITIONAL BLOCK IS NECESSARY
                            new_state = State(t=state.time, g=state.g + 1, predecessor=state, predecessor_action=aa)
                        new_state = semantic_attachment.external_function(new_state)

                    # next check applicable processes
                    happenings_list = grounded_instance.processes.get_applicable(new_state)
                    for hp_p1 in happenings_list:
                        new_state = new_state.apply_happening(hp_p1, from_state=from_state, create_new_state=new_state is state)

                    # set clock for the newly generated state after applying process effects
                    new_state.time = constants.fast_round(state.time + constants.DELTA_T, constants.NUMBER_PRECISION)
                    # new_state.set_time(time_passed)

                    # check TILs first thing after passing time
                    happenings_list = grounded_instance.events.get_applicable(new_state)
                    for hp_e_til in happenings_list:
                        if (hp_e_til.happening_type == 'timed_initial_event'):
                            new_state = new_state.apply_happening(hp_e_til, from_state=from_state, create_new_state=new_state is state)

                    # next check triggered events
                    happenings_list = grounded_instance.events.get_applicable(new_state)
                    for hp_e2 in happenings_list:
                        new_state = new_state.apply_happening(hp_e2, from_state=from_state, create_new_state=new_state is state)


                    ### TODO: CHECK IF THIS BLOCK IS NECESSARY
                    # if new_state is state:
                    #     new_state = copy.deepcopy(state)
                    #     new_state.predecessor_hashed = hash(from_state)

                    new_state.predecessor_action = aa

                else:
                    ### HAPPENINGS ORDER (for non-temporal domains): actions -> semantic attachments -> events
                    ### (TODO: CHECK IF THIS IS THE CORRECT ORDER OF HAPPENINGS)

                    new_state = state.apply_happening(aa, from_state=from_state, create_new_state=True)

                    # check events in non-temporal domains, if exist
                    if not constants.TEMPORAL_DOMAIN:

                        # check whether any semantic attachment are present, if applicable
                        if constants.SEMANTIC_ATTACHMENT:
                            new_state = semantic_attachment.external_function(new_state)

                        happenings_list = grounded_instance.events.get_applicable(new_state)
                        for hp_e in happenings_list:
                            new_state = new_state.apply_happening(hp_e, from_state=from_state, create_new_state=new_state is state)

                self.explored_states += 1

                new_state_hash = hash(VisitedState(new_state))
                if new_state.time <= constants.TIME_HORIZON and new_state.depth <= constants.DEPTH_LIMIT and grounded_instance.duration_constraints(new_state, constants):
                    
                    if (new_state_hash not in self.visited_hashmap) or \
                        (new_state_hash in self.visited_hashmap and constants.METRIC_MINIMIZE and new_state.metric < self.visited_hashmap[new_state_hash].state.metric) or \
                            (new_state_hash in self.visited_hashmap and not constants.METRIC_MINIMIZE and new_state.metric > self.visited_hashmap[new_state_hash].state.metric):
                        self.visited_hashmap[new_state_hash] = VisitedState(new_state)
                        self.enqueue_state(new_state)

                if self.explored_states % constants.PRINT_INFO == 0:
                    print_q = []
                    # visi = len(self.visited_hashmap)
                    time_checkpoint = time.time() - start_solve_time
                    print_q.append('[' + str("{:6.2f}".format(time_checkpoint)) + '] ==> states explored: ' + str(
                        self.explored_states))
                    print_q.append('\t\t ==> exploration rate: ' + str(
                        constants.fast_round(self.explored_states / time_checkpoint, 2)) + ' states/sec')
                    if (constants.ANYTIME):
                        print_q.append('\t\t ==> tracked goals: ' + str(len(self.reached_goal_states)))
                        print_q.append('\t\t ==> total goals found: ' + str(self.total_goals_found))
                        if len(self.reached_goal_states) > 0:
                            print_q.append(
                                '\t\t ==> best metric: {:6.3f}'.format(self.reached_goal_states[0].state.metric))
                        else:
                            print_q.append('\t\t ==> best metric: N/A')

                    if (not (constants.PRINT_ALL_STATES)):
                        for _ in range(len(print_q)):
                            sys.stdout.write("\x1b[1A\x1b[2K")  # move up cursor and delete whole line
                    # print_q.append(s)
                    for i in range(len(print_q)):
                        sys.stdout.write(print_q[i] + "\n")  # reprint the lines

            if (time.time() - start_solve_time) >= constants.TIMEOUT:
                if (constants.ANYTIME):
                    return self.reached_goal_states
                return None

        return None



    def enqueue_state(self, n_state):
        if constants.SEARCH_BFS:
            self.queue.append(n_state)
        elif constants.SEARCH_DFS:
            self.queue.appendleft(n_state)
        elif constants.SEARCH_GBFS:
            n_state.set_h_heuristic(heuristic_functions.heuristic_function(n_state))
            ''' changing enqueue to bisect.insort ==> needs performance comparison '''
            # self.queue.insert(0, n_state)
            # self.queue = sorted(self.queue, key=lambda elem: (elem.h))

            bisect.insort(self.queue, n_state)

            # self.queue.insert(bisect.bisect_left(self.queue, n_state), n_state)

            # self.queue.appendleft(n_state)
            # self.queue = collections.deque(sorted(self.queue, key=lambda elem: (elem.h)))

        elif constants.SEARCH_ASTAR:
            n_state.set_h_heuristic(heuristic_functions.heuristic_function(n_state))
            self.queue.appendleft(n_state)
            self.queue = collections.deque(sorted(self.queue, key=lambda elem: (elem.h + elem.g)))

        if constants.PRINT_ALL_STATES:
            print(n_state)


    def enqueue_goal(self, n_state):
        ''' changing enqueue to bisect.insort ==> needs performance comparison '''
        # print("\n\nNEW STATE METRIC: " + str(n_state.metric))

        if constants.METRIC_MINIMIZE:
            if (len(self.reached_goal_states) < constants.TRACKED_PLANS) or ((len(self.reached_goal_states) == constants.TRACKED_PLANS) \
                    and ((n_state.state.metric < self.reached_goal_states[-1].state.metric) or (n_state.state.metric == self.reached_goal_states[-1].state.metric and n_state.state.depth < self.reached_goal_states[-1].state.depth))):
                self.reached_goal_states.appendleft(n_state)
                self.reached_goal_states = collections.deque(sorted(self.reached_goal_states, key=lambda elem: (elem.state.metric, elem.state.depth)), maxlen=constants.TRACKED_PLANS)

        else:
            if (len(self.reached_goal_states) < constants.TRACKED_PLANS) or ((len(self.reached_goal_states) == constants.TRACKED_PLANS) \
                    and ((n_state.state.metric > self.reached_goal_states[-1].state.metric) or (n_state.state.metric == self.reached_goal_states[-1].state.metric and n_state.state.depth < self.reached_goal_states[-1].state.depth))):
                self.reached_goal_states.appendleft(n_state)
                self.reached_goal_states = collections.deque(sorted(self.reached_goal_states, key=lambda elem: (elem.state.metric, -elem.state.depth), reverse=True), maxlen=constants.TRACKED_PLANS)


    def get_trajectory(self, sstate: State):
        plan = []
        curr_v_state = VisitedState(sstate)

        while curr_v_state.state.predecessor_action is not None:
            # Changed copy.deepcopy(curr_v_state.state) -> copy.copy(curr_v_state.state)
            # using deepcopy here throws a RecursionError: "maximum recursion depth exceeded while calling a Python object"
            plan.insert(0, (curr_v_state.state.predecessor_action, copy.copy(curr_v_state.state)))
            curr_v_state = self.visited_hashmap[curr_v_state.state.predecessor_hashed]
        return plan
