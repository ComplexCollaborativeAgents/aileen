from typing import List
from agent.planning_agent.pddl_generator.base_generator import BaseGenerator, PDDLProblem
from agent.environment_model.state_parser import ThorStateParser
from agent.environment_model.state_definition import GroundedPredicate, EnvironmentState

class PDDLProblemGenerator(BaseGenerator):
    def __init__(self, _path: str, name: List[str]):
        super().__init__(_path, name[0])
        self.domain_name = name[1] # at 0th index there is problem name and 1st index position we have domain name
        self.environment = EnvironmentState()


    def generate(self, world_server, _current_state, goal_condition):
        self.parser = ThorStateParser(world_server)
        problem = PDDLProblem(self.name, self.domain_name)
        objects = self.get_objects(_current_state)
        initial_state = self.get_initial_state(_current_state)

        problem.set_objects(objects)
        problem.set_initial_state(initial_state)
        problem.set_goal(goal_condition)
        problem.write_to_file(self.path)

        return problem


    def get_initial_state(self, _current_state):
        initial_state = list()
        cells = self.get_cell_definition(_current_state)
        reachability = self.get_reachability(_current_state)
        robot_state = self.get_robot_location(_current_state)
        obj_properties = self.get_object_properties(_current_state)

        [initial_state.extend(a) for a in (cells, reachability, robot_state, obj_properties)]

        return initial_state

    def get_objects(self, _current_state):
        obj_ids = self.parser.get_object_ids(_current_state)

        return {"interactable": obj_ids}

    def get_object_properties(self, _current_state):
        predicates = list()
        predicates.extend(self.get_movable_objects(_current_state))
        predicates.extend(self.get_openable_objects(_current_state))
        predicates.extend(self.get_pickable_objects(_current_state))
        predicates.extend(self.get_receptacle_objects(_current_state))

        return predicates


    def get_movable_objects(self, _current_state):
        predicates = list()
        objs = self.parser.get_moveable_object_ids(_current_state)

        for obj_id in objs:
            domain_pred = self.environment.predicates["moveable"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_openable_objects(self, _current_state):
        predicates = list()
        objs = self.parser.get_openable_object_ids(_current_state)

        for obj_id in objs:
            domain_pred = self.environment.predicates["openable"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_pickable_objects(self, _current_state):
        predicates = list()
        objs = self.parser.get_pickable_object_ids(_current_state)

        for obj_id in objs:
            domain_pred = self.environment.predicates["pickable"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_receptacle_objects(self, _current_state):
        predicates = list()
        objs = self.parser.get_receptacle_object_ids(_current_state)

        for obj_id in objs:
            domain_pred = self.environment.predicates["receptacle"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_robot_location(self, _current_state):
        robot_location = self.parser.get_agent_location(_current_state)
        return robot_location

    def get_reachability(self, _current_state):
        return []


    def get_cell_definition(self, _current_state):
        return []

