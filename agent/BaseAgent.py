import random
import logging, coloredlogs

ACTION_MOVE_RIGHT = "MoveRight"
ACTION_MOVE_LEFT = "MoveLeft"
ACTION_MOVE_AHEAD = "MoveAhead"
ACTION_MOVE_BACK = "MoveBack"
ACTION_ROTATE_RIGHT = "RotateRight"
ACTION_ROTATE_LEFT = "RotateLeft"

class Agent():
    def __init__(self):
        self._logger = logging.getLogger(__name__)
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