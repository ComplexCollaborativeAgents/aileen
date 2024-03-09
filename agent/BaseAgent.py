import random
import logging, coloredlogs
from language.Interpreter import Interpreter

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

class Agent():
    def __init__(self):
        self._logger = logging.getLogger(__name__)
        self._interpreter = Interpreter()
        coloredlogs.install(level='DEBUG', logger=self._logger)

    def perceive_symbolic_state(self, event):
        if event is not None:
            self._logger.info("received state: {}".format(event["objects"]))

    def perceive(self, event):
        if event is not None:
            print(event.frame)

    def choose_action(self, event):
        state = self.perceive_symbolic_state(event=event)
        #state = self.perceive(event=event)
        list_actions = [ACTION_MOVE_BACK, ACTION_MOVE_AHEAD, ACTION_MOVE_RIGHT, ACTION_MOVE_LEFT]
        action = random.choice(list_actions)
        return action

    def process_utterance(self, utterance):
        json_string = self._interpreter.interpret(utterance)
        return json_string
