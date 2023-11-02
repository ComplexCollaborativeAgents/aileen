class Action():
    def __init__(self):
        self.name = "Done"
        # self.conditions = self.get_conditions()

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
        return conditions

    def set_action_parameters(self, **kwagrs):
        raise NotImplementedError()

    def to_interface(self):
        interface = {"action": self.name}

        return interface


class TeleportAction(Action):
    def __init__(self, _position=None, _rotation=None, _horizon=0, _standing=True):
        super().__init__()
        self.name = "Teleport"
        self.set_action_parameters(_position, _rotation, _horizon, _standing)

    def get_conditions(self):
        self.conditions = super().get_conditions()
        self.conditions["reachable"] = True

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

class PickObjectAction(Action):
    def __init__(self, _objectID=None, _forceAction=False, _manualInteract=False):
        super().__init__()
        self.name = "PickupObject"
        self.set_action_parameters(_objectID, _forceAction, _manualInteract)

    def get_conditions(self):
        self.conditions = super().get_conditions()
        self.conditions["pickable"] = True

    def set_action_parameters(self, _objectID, _forceAction=False, _manualInteract=False):
        self.objectID = _objectID
        self.forceAction = _forceAction
        self.manualInteract = _manualInteract

    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.forceAction
        interface["manualInteract"] = self.manualInteract

        return interface


class PutObjectAction(Action):
    def __init__(self, _objectID=None, _forceAction=False, _placeStationary=True):
        super().__init__()
        self.name = "PutObject"
        self.set_action_parameters(_objectID, _forceAction, _placeStationary)

    def get_conditions(self):
        self.conditions = super().get_conditions()
        self.conditions["pickable"] = True
        self.conditions["receptacle"] = True

    def set_action_parameters(self, _objectID, _forceAction=False, _placeStationary=True):
        self.objectID = _objectID
        self.forceAction = _forceAction
        self.placeStationary = _placeStationary

    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.forceAction
        interface["placeStationary"] = self.placeStationary

        return interface

class OpenObjectAction(Action):
    def __init__(self, _objectID=None, _openness=1, _forceAction=False):
        super().__init__()
        self.name = "OpenObject"
        self.set_action_parameters(_objectID, _openness, _forceAction)

    def get_conditions(self):
        self.conditions = super().get_conditions()
        self.conditions["openable"] = True

    def set_action_parameters(self, _objectID, _openness, _forceAction=False):
        self.objectID = _objectID
        self.forceAction = _forceAction
        self.openness = _openness

    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.forceAction
        interface["openness"] = self.openness

        return interface

class CloseObjectAction(Action):
    def __init__(self, _objectID=None, _forceAction=False):
        super().__init__()
        self.name = "CloseObject"
        self.set_action_parameters(_objectID, _forceAction)

    def get_conditions(self):
        self.conditions = super().get_conditions()
        self.conditions["openable"] = True

    def set_action_parameters(self, _objectID, _forceAction=False):
        self.objectID = _objectID
        self.forceAction = _forceAction

    def to_interface(self):
        interface = super().to_interface()
        interface["objectId"] = self.objectID
        interface["forceAction"] = self.forceAction

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