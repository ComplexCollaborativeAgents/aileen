import random
from enum import Enum


ACTION_MOVE_RIGHT = "MoveRight"
ACTION_MOVE_LEFT = "MoveLeft"
ACTION_MOVE_AHEAD = "MoveAhead"
ACTION_MOVE_BACK = "MoveBack"

class Agent():
    def __init__(self):
        pass
    def perceive_symbolic_state(self, event):
        if event is not None:
            print(event.metadata["objects"])

    def perceive(self, event):
        if event is not None:
            print(event.frame)

    def choose_action(self, event):
        state = self.perceive_symbolic_state(event=event)
        #state = self.perceive(event=event)
        list_actions = [ACTION_MOVE_BACK, ACTION_MOVE_AHEAD, ACTION_MOVE_RIGHT, ACTION_MOVE_LEFT]
        action = random.choice(list_actions)
        return action