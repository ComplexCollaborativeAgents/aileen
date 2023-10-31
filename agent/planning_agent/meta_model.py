

class Model():
    """
    Class that defines actions and the properties required to construct those actions for sending to interface
    """
    ACTION_MOVE_RIGHT = "MoveRight"
    ACTION_MOVE_LEFT = "MoveLeft"
    ACTION_MOVE_AHEAD = "MoveAhead"
    ACTION_MOVE_BACK = "MoveBack"
    ACTION_ROTATE_RIGHT = "RotateRight"
    ACTION_ROTATE_LEFT = "RotateLeft"
    TELEPORT = "Teleport"
    PICK_OBJECT = "PickupObject"
    PUT_OBJECT = "PutObject"
    DROP_OBJECT = "DropHandObject"
    THROW_OBJECT = "ThrowObject"
    MOVE_OBJECT_AHEAD = "MoveHeldObjectAhead"
    MOVE_OBJECT_BACK = "MoveHeldObjectBack"
    MOVE_OBJECT_LEFT = "MoveHeldObjectLeft"
    MOVE_OBJECT_RIGHT = "MoveHeldObjectRight"
    MOVE_OBJECT_UP = "MoveHeldObjectUp"
    MOVE_OBJECT_DOWN = "MoveHeldObjectDown"
    ROTATE_OBJECT = "RotateHeldObject"

    def __init__(self):
        self.actions = self.get_all_actions()


