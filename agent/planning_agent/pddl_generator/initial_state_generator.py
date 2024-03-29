from typing import List
from agent.planning_agent.pddl_generator.base_generator import BaseGenerator, PDDLInitialState
from agent.environment_model.state_parser import ThorStateParser
from agent.environment_model.state_definition import GroundedPredicate, EnvironmentState

class PDDLInitialStateGenerator(BaseGenerator):
    def __init__(self):
        # this wont be directly writing to the file, so not sending a path
        super().__init__("no_file", "dummy")


    def generate(self, _current_state, required_objects = list()):
        self.state = PDDLInitialState()
        self.objects = self.get_objects(_current_state, required_objects)
        self.initial_state = self.get_initial_state(_current_state)

        self.state.set_objects(self.objects)
        self.state.set_initial_state(self.initial_state)


    def get_initial_state(self, _current_state):
        initial_state = list()
        cell_predicates = self.get_cell_reachability(_current_state)
        robot_state = self.get_robot_location(_current_state)
        obj_properties = self.get_object_properties(_current_state)

        [initial_state.extend(a) for a in (cell_predicates, robot_state, obj_properties)]

        return initial_state

    def get_objects(self, _current_state, _required_objects: List):
        obj_ids = list()
        types_added = set()
        if self.prune_objects and len(_required_objects) > 0:
            objects = self.parser.get_object_ids_by_type(_current_state)

            for _type in objects.keys():
                for r_obj in _required_objects:
                    if _type in r_obj.lower() and _type not in types_added:
                        obj_ids.extend(objects[_type])
                        types_added.add(_type)

        else:
            obj_ids = self.parser.get_object_ids(_current_state)
            self.prune_objects

        self.obj_ids = obj_ids

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

    def prune_list_objects(self, all_objects):
        objects = list()
        all_objects = set(all_objects)
        if self.prune_objects:
            for obj_id in self.obj_ids:
                if obj_id in all_objects:
                    objects.append(obj_id)
        else:
            objects = all_objects

        return objects


    def get_movable_objects(self, _current_state):
        predicates = list()
        all_objs = self.parser.get_moveable_object_ids(_current_state)
        objs = self.prune_list_objects(all_objs)

        for obj_id in objs:
            domain_pred = self.environment.predicates["moveable"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_openable_objects(self, _current_state):
        predicates = list()
        all_objs = self.parser.get_openable_object_ids(_current_state)
        objs = self.prune_list_objects(all_objs)

        for obj_id in objs:
            domain_pred = self.environment.predicates["openable"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_pickable_objects(self, _current_state):
        predicates = list()
        all_objs = self.parser.get_pickable_object_ids(_current_state)
        objs = self.prune_list_objects(all_objs)

        for obj_id in objs:
            domain_pred = self.environment.predicates["pickable"]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, {"interactable": obj_id})
            predicates.append(pred)

        return predicates


    def get_receptacle_objects(self, _current_state):
        predicates = list()
        all_objs = self.parser.get_receptacle_object_ids(_current_state)
        objs = self.prune_list_objects(all_objs)

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
            if self.robot_name not in cell:
                domain_location = self.environment.predicates["location"]
                location_pred = GroundedPredicate(domain_location.name, domain_location.properties, {"cell": cell, "interactable": cell.split("_")[1]})
                preds.append(location_pred)

            domain_reachability = self.environment.predicates["reachable"]
            reachable_pred = GroundedPredicate(domain_reachability.name, domain_reachability.properties, {"cell": cell})
            reachability_preds.append(reachable_pred)

        preds.extend(reachability_preds)
        return preds

