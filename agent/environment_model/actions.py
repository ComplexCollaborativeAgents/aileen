import math
from agent.environment_model.state_definition import EnvironmentState, Predicate, GroundedPredicate, DomainPredicate

class Action():
    def __init__(self):
        self.environment = EnvironmentState()
        self.name = "Done"
        self.pddl_name = "done"
        # self.conditions = self.get_conditions()
        self.separator = "\n\t\t"
        self.pddl_action_string = "(:action {NAME}\n\t:parameters {PARAMETERS}\n\t:precondition (and\n\t\t{PRECONDITIONS}\n\t)\n\t:effect (and\n\t\t{EFFECTS}\n\t)\n)"

    def get_conditions(self):
        conditions = {
            "reachable": False,
            "receptacle": False,
            "interactable": False,
            "toggleable": False,
            "breakable": False,
            "fillable": False,
            "cookable": False,
            "sliceable": False,
            "openable": False,
            "pickable": False,
            "moveable": False,
            "holdable": False
        }

        true_conditions = list()
        return conditions, true_conditions

    def get_pddl_preconditions(self):
        self.conditions, self.true_conditions = self.get_conditions()
        preconditions = list()

        return preconditions

    def set_action_parameters(self, **kwargs):
        raise NotImplementedError()

    def get_pddl_parameters(self):
        return None

    def get_pddl_effects(self):
        return None

    def to_interface(self):
        interface = {"action": self.name}

        return interface

    def to_pddl(self):
        parameters = self.get_action_parameters()
        pre_conditions = self.get_pddl_preconditions()
        effects = self.get_pddl_effects()

        return self.pddl_action_string.format(
            NAME=self.pddl_name,
            PARAMETERS = str(parameters),
            PRECONDITIONS = self.separator.join([str(pre) for pre in pre_conditions]),
            EFFECTS = self.separator.join([str(eff) for eff in effects])
        )



class TeleportAction(Action):
    def __init__(self, _position=None, _rotation=None, _horizon=0, _standing=True):
        super().__init__()
        self.name = "Teleport"
        self.pddl_name = "teleport"
        self.set_action_parameters(_position, _rotation, _horizon, _standing)

    def get_conditions(self):
        self.conditions, self.true_conditions = super().get_conditions()
        self.conditions["reachable"] = True
        self.true_conditions.append("reachable")

        return self.conditions, self.true_conditions


    def get_action_parameters(self):
        parameters = DomainPredicate("", ["cell"], {"cell": ["from", "to"]})

        return parameters


    def get_pddl_preconditions(self):
        self.get_conditions()
        preconditions = list()
        for cond in self.true_conditions:
            domain_pred = self.environment.predicates[cond]
            pred = Predicate(domain_pred.name, ["to"])
            preconditions.append(pred)

        dom_robot = self.environment.predicates["robot"]
        #dom_cell_x = self.environment.functions["cell_x"]
        #dom_cell_y = self.environment.functions["cell_y"]
        #dom_robot_x = self.environment.functions["robot_x"]
        #dom_robot_y = self.environment.functions["robot_y"]
        #cell_x_from = Predicate(dom_cell_x.name, ["from"])
        #cell_y_from = Predicate(dom_cell_y.name, ["from"])

        robot_from = Predicate(dom_robot.name, ["from"])
        # robot_cell_y_from = GroundedPredicate(dom_robot_y.name, [], {dom_robot_y.name: cell_y_from}, True, False, "=")

        preconditions.extend([robot_from])

        return preconditions


    def get_pddl_effects(self):
        dom_robot = self.environment.predicates["robot"]
        robot_to = Predicate(dom_robot.name, ["to"])
        robot_not_from = Predicate(dom_robot.name, ["from"], True)

        #dom_cell_x = self.environment.functions["cell_x"]
        #dom_cell_y = self.environment.functions["cell_y"]
        #dom_robot_x = self.environment.functions["robot_x"]
        #dom_robot_y = self.environment.functions["robot_y"]
        #dom_prev_robot_x = self.environment.functions["prev_robot_x"]
        #dom_prev_robot_y = self.environment.functions["prev_robot_y"]

        #cell_x_from = Predicate(dom_cell_x.name, ["from"])
        #cell_y_from = Predicate(dom_cell_y.name, ["from"])
        #cell_x_to = Predicate(dom_cell_x.name, ["to"])
        #cell_y_to = Predicate(dom_cell_y.name, ["to"])

        #robot_cell_x_to = GroundedPredicate(dom_robot_x.name, [], {dom_robot_x.name: cell_x_to}, True, False, "assign")
        #robot_cell_y_to = GroundedPredicate(dom_robot_y.name, [], {dom_robot_y.name: cell_y_to}, True, False, "assign")
        #prev_robot_cell_x_from = GroundedPredicate(dom_prev_robot_x.name, [], {dom_prev_robot_x.name: cell_x_from}, True, False, "assign")
        #prev_robot_cell_y_from = GroundedPredicate(dom_prev_robot_y.name, [], {dom_prev_robot_y.name: cell_y_from}, True, False, "assign")

        #return [prev_robot_cell_x_from, prev_robot_cell_y_from, robot_cell_x_to, robot_cell_y_to]
        return [robot_to, robot_not_from]


    def set_action_parameters(self, _position, _rotation, _horizon=0, _standing=True):
        self.position = _position
        self.rotation = _rotation
        self.horizon = _horizon
        self.standing = _standing

    def to_interface(self):
        return {
            "action": self.name,
            "position": self.position,
            "rotation": self.rotation,
            "horizon": self.horizon,
            "standing": self.standing
        }


class TeleportGroundingAction(TeleportAction):
    def __init__(self, parser, current_state, positions, _obj, _holding = False):
        """Action to find a location near an object """
        self.parser = parser
        self.closest_distance = 0.5
        self.holding = _holding
        position, rotation = self.get_reachable_position(current_state, positions, _obj)
        super().__init__(position, rotation)


    def get_reachable_position(self, current_state, positions, obj_id):
        obj_center = self.get_center_position(current_state, obj_id)
        position = self.get_closest_position(obj_center, positions)
        print(f"positions object {obj_center}, robot {position}")
        rot = self.get_rotation(obj_center['x'], obj_center['z'], position['x'], position['z'])
        rotation = {
            'x': 0,
            'y': rot,
            'z': 0
        }

        print("final position and rotation  ", position, rotation)

        return position, rotation


    def get_center_position(self, current_state, obj_id):
        center = self.parser.get_object_center(obj_id, current_state)

        return center


    def get_closest_position(self, center, positions):
        min_distance = 1000
        min_position = positions[0]
        x1 = center['x']
        z1 = center['z']
        closest_distance = self.closest_distance
        if self.holding:
            closest_distance = 1.0

        for pos in positions:
            distance = self.get_distance(x1, z1, pos['x'], pos['z'])

            if distance < min_distance and distance > closest_distance:
                min_distance = distance
                min_position = pos

        return min_position


    def get_distance(self, x1, z1, x2, z2):
        return math.sqrt((x2 - x1)**2 + (z2 - z1)**2)


    def get_rotation(self, x1, z1, x2, z2):
        slope = (x1 - x2)/(z1 - z2)
        degrees = math.degrees(math.atan(slope))

        if degrees < 0:
            if x2 > x1:
                degrees += 360
            else:
                degrees += 180.0

        return degrees


class PickObjectAction(Action):
    def __init__(self, _objectID, _force_action=False, _manualInteract=False):
        super().__init__()
        self.name = "PickupObject"
        self.objectID = _objectID
        self.pddl_name = f"pickup_{self.objectID}"
        self.set_action_parameters(_objectID, _force_action, _manualInteract)

    def get_conditions(self):
        self.conditions, self.true_conditions = super().get_conditions()
        self.conditions["pickable"] = True
        self.true_conditions.extend(["pickable"])

        return self.conditions, self.true_conditions

    def set_action_parameters(self, _objectID, _force_action=False, _manualInteract=False):
        self.objectID = _objectID
        self.force_action = _force_action
        self.manualInteract = _manualInteract

    def get_action_parameters(self):
        self.groundings = {"cell": "c", "interactable": self.objectID}
        parameters = DomainPredicate("", ["cell"], self.groundings)

        return parameters

    def get_pddl_preconditions(self):
        self.get_conditions()
        preconditions = list()
        for cond in self.true_conditions:
            domain_pred = self.environment.predicates[cond]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, self.groundings)
            preconditions.append(pred)

        #dom_near = self.environment.predicates["near"]
        dom_robot = self.environment.predicates["robot"]
        dom_location = self.environment.predicates["location"]
        dom_holding = self.environment.predicates["holding"]
        #near = Predicate(dom_near.name, [self.groundings["cell"]])
        groundings = dict(self.groundings)
        groundings["cell"] = "?c"
        robot_location = Predicate(dom_robot.name, [self.groundings["cell"]])
        location = GroundedPredicate(dom_location.name, dom_location.properties, groundings)
        not_holding = GroundedPredicate(dom_holding.name, dom_holding.properties, self.groundings, False, True)

        preconditions.extend([robot_location, location, not_holding])

        return preconditions

    def get_pddl_effects(self):
        dom_holding = self.environment.predicates["holding"]
        dom_location = self.environment.predicates["location"]
        #dom_location_x = self.environment.functions["location_x"]
        #dom_location_y = self.environment.functions["location_y"]
        #dom_robot_x = self.environment.functions["robot_x"]
        #dom_robot_y = self.environment.functions["robot_y"]
        holding = GroundedPredicate(dom_holding.name, dom_holding.properties, self.groundings, False, False)
        groundings = dict(self.groundings)
        groundings["cell"] = "?c"
        not_location = GroundedPredicate(dom_location.name, dom_location.properties, groundings, False, True)
        #self.groundings[dom_location_x.name] =  dom_robot_x.get_predicate()
        #self.groundings[dom_location_y.name] =  dom_robot_y.get_predicate()
        #location_x = GroundedPredicate(dom_location_x.name, dom_location_x.properties, self.groundings)
        #location_y = GroundedPredicate(dom_location_y.name, dom_location_y.properties, self.groundings)

        return [holding, not_location]


    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.force_action
        interface["manualInteract"] = self.manualInteract

        return interface


class PutObjectAction(Action):
    def __init__(self, _objectID, _force_action=False, _place_stationary=True):
        super().__init__()
        self.name = "PutObject"
        self.pddl_name = f"put_{_objectID}"
        self.set_action_parameters(_objectID, _force_action, _place_stationary)

    def get_conditions(self):
        self.conditions, self.true_conditions = super().get_conditions()
        self.conditions["pickable"] = True
        self.conditions["receptacle"] = True

        return self.conditions, self.true_conditions

    def set_action_parameters(self, _objectID, _force_action=False, _place_stationary=True):
        self.objectID = _objectID
        self.force_action = _force_action
        self.place_stationary = _place_stationary


    def get_action_parameters(self):
        self.groundings = {"cell": "?c", "interactable": self.objectID}
        groundings = dict(self.groundings)
        groundings["cell"] = "c"
        parameters = DomainPredicate("", ["cell"], groundings)

        return parameters

    def get_pddl_preconditions(self):
        self.get_conditions()
        preconditions = list()
        for cond in self.true_conditions:
            domain_pred = self.environment.predicates[cond]
            pred = Predicate(domain_pred.name, [self.objectID])
            preconditions.append(pred)

        #dom_near = self.environment.predicates["near"]
        dom_robot = self.environment.predicates["robot"]
        dom_location = self.environment.predicates["location"]
        dom_holding = self.environment.predicates["holding"]
        #near = GroundedPredicate(dom_near.name, dom_near.properties, self.groundings)
        robot_location = Predicate(dom_robot.name, ["c"])
        not_location = GroundedPredicate(dom_location.name, dom_location.properties, self.groundings, False, True)
        holding = GroundedPredicate(dom_holding.name, dom_holding.properties, self.groundings, False, False)

        preconditions.extend([robot_location, not_location, holding])

        return preconditions

    def get_pddl_effects(self):
        dom_holding = self.environment.predicates["holding"]
        dom_location = self.environment.predicates["location"]
        #dom_location_x = self.environment.functions["location_x"]
        #dom_location_y = self.environment.functions["location_y"]
        #dom_robot_x = self.environment.functions["robot_x"]
        #dom_robot_y = self.environment.functions["robot_y"]
        not_holding = GroundedPredicate(dom_holding.name, dom_holding.properties, self.groundings, False, True)
        location = GroundedPredicate(dom_location.name, dom_location.properties, self.groundings, False, False)
        #self.groundings[dom_location_x.name] = dom_robot_x.get_predicate()
        #self.groundings[dom_location_y.name] = dom_robot_y.get_predicate()
        #location_x = GroundedPredicate(dom_location_x.name, dom_location_x.properties, self.groundings)
        #location_y = GroundedPredicate(dom_location_y.name, dom_location_y.properties, self.groundings)

        return [not_holding, location]


    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.force_action
        interface["placeStationary"] = self.place_stationary

        return interface


class PutInsideObjectAction(PutObjectAction):
    def __init__(self, _object1: str, _object2: str, _force_action = False, _place_stationary = True):
        # put object1 inside object2
        # this is basically an extension for pddl only.
        # interface action is based on object2
        super().__init__(_object2, _force_action, _place_stationary)
        self.pddl_name = f"put_inside_{_object2}"
        self.set_action_parameters(_object1, _object2, _force_action, _place_stationary)


    def set_action_parameters(self, _object1, _object2, _force_action = False, _place_stationary = True):
        super().set_action_parameters(_object2, _force_action, _place_stationary)
        self.objectID2 = _object1

    def get_action_parameters(self):
        self.groundings = {"cell": "?c", "interactable": "?p"}
        parameters = DomainPredicate("", ["interactable", "cell"], {"interactable": "p", "cell": "c"})

        return parameters


    def get_pddl_preconditions(self):
        self.get_conditions()
        preconditions = list()
        for cond in self.true_conditions:
            domain_pred = self.environment.predicates[cond]
            pred = Predicate(domain_pred.name, [self.objectID])
            preconditions.append(pred)

        dom_robot = self.environment.predicates["robot"]
        dom_location = self.environment.predicates["location"]
        dom_holding = self.environment.predicates["holding"]
        robot_location = Predicate(dom_robot.name, ["c"])
        # not_location = GroundedPredicate(dom_location.name, dom_location.properties, self.groundings, False, True)
        groundings = {"cell": "?c", "interactable": self.objectID}
        location = GroundedPredicate(dom_location.name, dom_location.properties, groundings, False, False)
        holding = GroundedPredicate(dom_holding.name, dom_holding.properties, self.groundings, False, False)

        dom_opened = self.environment.predicates["opened"]
        opened = GroundedPredicate(dom_opened.name, dom_opened.properties, groundings, False, False)

        preconditions.extend([robot_location, location, holding, opened])
        return preconditions


    def get_pddl_effects(self):
        effects = super().get_pddl_effects()

        dom_in = self.environment.predicates["in"]
        grounding = {"interactable": [self.objectID, "?p"]}
        _in = GroundedPredicate(dom_in.name, dom_in.properties, grounding, False, False)
        effects.append(_in)

        return effects


class PutOnObjectAction(PutObjectAction):
    def __init__(self, _object1: str, _object2: str, _force_action = False, _place_stationary = True):
        # put object1 inside object2
        # this is basically an extension for pddl only.
        # interface action is based on object2
        super().__init__(_object2, _force_action, _place_stationary)
        self.pddl_name = f"put_on_{self._object2}"
        self.set_action_parameters(_object1, _object2, _force_action, _place_stationary)


    def set_action_parameters(self, _object1, _object2, _force_action = False, _place_stationary = True):
        super().set_action_parameters(_object2, _force_action, _place_stationary)
        self.objectID2 = _object1

    def get_action_parameters(self):
        self.groundings = {"cell": "?c", "interactable": "?p"}
        parameters = DomainPredicate("", ["interactable", "cell"], {"interactable": "p", "cell": "c"})

        return parameters


    def get_pddl_preconditions(self):
        preconditions = super().get_pddl_preconditions()
        dom_opened = self.environment.predicates["clear"]
        groundings = {"cell": "?c", "interactable": self.objectID}
        opened = GroundedPredicate(dom_opened.name, dom_opened.properties, groundings, False, False)
        location = GroundedPredicate(dom_location.name, dom_location.properties, groundings, False, False)
        preconditions.append(opened)

        return preconditions


    def get_pddl_effects(self):
        effects = super().get_pddl_effects()

        dom_on = self.environment.predicates["on"]
        grounding = {"interactable": ["p", self.objectID]}
        _on = GroundedPredicate(dom_on.name, dom_on.properties, grounding, False, False)
        effects.append(_on)

        return effects


class OpenObjectAction(Action):
    def __init__(self, _objectID, _openness=1, _force_action=True):
        super().__init__()
        self.name = "OpenObject"
        self.pddl_name = f"open_{_objectID}"
        self.objectID = _objectID
        self.set_action_parameters(_objectID, _openness, _force_action)

    def get_conditions(self):
        self.conditions, self.true_conditions = super().get_conditions()
        self.conditions["openable"] = True
        self.true_conditions.append("openable")

        return self.conditions, self.true_conditions

    def set_action_parameters(self, _objectID, _openness, _force_action=False):
        self.objectID = _objectID
        self.force_action = _force_action
        self.openness = _openness


    def get_action_parameters(self):
        self.groundings = {"cell": "?c", "interactable": self.objectID}
        groundings = dict(self.groundings)
        groundings["cell"] = "c"
        parameters = DomainPredicate("", ["cell"], groundings)

        return parameters

    def get_pddl_preconditions(self):
        self.get_conditions()
        preconditions = list()
        for cond in self.true_conditions:
            domain_pred = self.environment.predicates[cond]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, self.groundings)
            preconditions.append(pred)

        dom_robot = self.environment.predicates["robot"]
        #dom_near = self.environment.predicates["near"]
        dom_location = self.environment.predicates["location"]
        dom_opened = self.environment.predicates["opened"]
        robot_location = Predicate(dom_robot.name, ["c"])
        #near = GroundedPredicate(dom_near.name, dom_near.properties, self.groundings)
        location = GroundedPredicate(dom_location.name, dom_location.properties, self.groundings)
        not_opened = GroundedPredicate(dom_opened.name, dom_opened.properties, self.groundings, False, True)

        preconditions.extend([robot_location, location, not_opened])

        return preconditions

    def get_pddl_effects(self):
        dom_opened = self.environment.predicates["opened"]
        opened = GroundedPredicate(dom_opened.name, dom_opened.properties, self.groundings, False, False)

        return [opened]


    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.force_action
        interface["openness"] = self.openness

        return interface

class CloseObjectAction(Action):
    def __init__(self, _objectID, _force_action=False):
        super().__init__()
        self.name = "CloseObject"
        self.pddl_name = f"close_{_objectID}"
        self.set_action_parameters(_objectID, _force_action)

    def get_conditions(self):
        self.conditions, self.true_conditions = super().get_conditions()
        self.conditions["openable"] = True
        self.true_conditions.append("openable")

        return self.conditions, self.true_conditions

    def set_action_parameters(self, _objectID, _force_action=False):
        self.objectID = _objectID
        self.force_action = _force_action

    def get_action_parameters(self):
        self.groundings = {"cell": "?c", "interactable": self.objectID}
        groundings = dict(self.groundings)
        groundings["cell"] = "c"
        parameters = DomainPredicate("", ["cell"], groundings)

        return parameters

    def get_pddl_preconditions(self):
        self.get_conditions()
        preconditions = list()
        for cond in self.true_conditions:
            domain_pred = self.environment.predicates[cond]
            pred = GroundedPredicate(domain_pred.name, domain_pred.properties, self.groundings)
            preconditions.append(pred)

        dom_robot = self.environment.predicates["robot"]
        #dom_near = self.environment.predicates["near"]
        dom_location = self.environment.predicates["location"]
        dom_opened = self.environment.predicates["opened"]
        robot_location = Predicate(dom_robot.name, ["c"])
        #near = GroundedPredicate(dom_near.name, dom_near.properties, self.groundings)
        location = GroundedPredicate(dom_location.name, dom_location.properties, self.groundings)
        opened = GroundedPredicate(dom_opened.name, dom_opened.properties, self.groundings, False, False)

        preconditions.extend([robot_location, location, opened])

        return preconditions

    def get_pddl_effects(self):
        dom_opened = self.environment.predicates["opened"]
        not_opened = GroundedPredicate(dom_opened.name, dom_opened.properties, self.groundings, False, True)

        return [not_opened]

    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.force_action
        return interface


class GetInteractablePoses(Action):
    def __init__(self, _objectID, _standing=True):
        super().__init__()
        self.name = "GetInteractablePoses"
        self.set_action_parameters(_objectID, _standing)

    def get_conditions(self):
        pass

    def set_action_parameters(self, _objectID, _standing):
        self.objectID = _objectID
        self.standing = _standing

    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["standings"] = [self.standing]
        return interface
