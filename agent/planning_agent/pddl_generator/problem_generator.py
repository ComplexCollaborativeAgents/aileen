from typing import List
from agent.planning_agent.pddl_generator.base_generator import BaseGenerator, PDDLProblem
from agent.environment_model.state_parser import ThorStateParser
from agent.environment_model.state_definition import GroundedPredicate, EnvironmentState

class PDDLProblemGenerator(BaseGenerator):
    def __init__(self, _path: str, name: List[str]):
        super().__init__(_path, name[0])
        self.domain_name = name[1] # at 0th index there is problem name and 1st index position we have domain name
        self.environment = EnvironmentState()
        self.robot_name = "thor"


    def generate(self, world_server, _current_state, goal_condition):
        self.parser = ThorStateParser(world_server)
        problem = PDDLProblem(self.name, self.domain_name)
        self.objects = self.get_objects(_current_state)
        self.initial_state = self.get_initial_state(_current_state)

        problem.set_objects(self.objects)
        problem.set_initial_state(self.initial_state)
        problem.set_goal(goal_condition)
        problem.write_to_file(self.path)

        return problem


    def get_initial_state(self, _current_state):
        initial_state = list()
        cell_predicates = self.get_cell_reachability(_current_state)
        robot_state = self.get_robot_location(_current_state)
        obj_properties = self.get_object_properties(_current_state)

        [initial_state.extend(a) for a in (cell_predicates, robot_state, obj_properties)]

        return initial_state

    def get_objects(self, _current_state):
        obj_ids = self.parser.get_object_ids(_current_state)
        cells = list()

        for obj_id in obj_ids:
            cell = f"c_{obj_id}"
            cells.append(cell)

        cell_robot = f"c_{self.robot_name}"
        cells.append(cell_robot)

        return {"cell": cells, "interactable": obj_ids}

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
        #robot_location = self.parser.get_agent_location(_current_state)
        domain_robot = self.environment.predicates["robot"]
        cell = f"c_{self.robot_name}"
        robot_location_pred = GroundedPredicate(domain_robot.name, domain_robot.properties, {"cell": cell})

        return [robot_location_pred]


    def get_cell_reachability(self, _current_state):
        # assuming there is a cell for every object
        preds = list()
        reachability_preds = list()
        for cell in self.objects["cell"]:
            domain_location = self.environment.predicates["location"]
            location_pred = GroundedPredicate(domain_location.name, domain_location.properties, {"cell": cell, "interactable": cell.split("_")[1]})
            preds.append(location_pred)

            domain_reachability = self.environment.predicates["reachable"]
            reachable_pred = GroundedPredicate(domain_reachability.name, domain_reachability.properties, {"cell": cell})
            reachability_preds.append(reachable_pred)

        preds.extend(reachability_preds)
        return preds

