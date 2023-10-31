from agent.BaseAgent import *
from agent.environment_model.actions import *

class PlanningAgent(Agent):
    def __init__(self):
        super().__init__()
        self.current_plan = list()
        self.has_planned = False

    def choose_action(self, current_state):
        if len(self.current_plan) == 0 and not self.has_planned:
            self.current_plan = self.plan()
            self.has_planned = True

        if len(self.current_plan) == 0:
            return None

        return self.current_plan.pop(0).to_interface()

    def plan(self):
        print("plan for picking bread and putting it in the fridge")
        teleport_bread = TeleportAction({'x': 0.0, 'y': 0.9799999594688416, 'z': 1.75}, {'x': 0, 'y': 270, 'z': 0})
        pick_bread = PickObjectAction("Bread|-00.92|+00.99|+02.27")
        teleport_fridge = TeleportAction({'x': 0.0, 'y': 0.9799999594688416, 'z': 0.0}, {'x': 0, 'y': 270, 'z': 0})
        open_refrigerator = OpenObjectAction("Fridge|-01.00|+00.00|+00.12")
        put_bread = PutObjectAction("Fridge|-01.00|+00.00|+00.12")
        close_refrigerator = CloseObjectAction("Fridge|-01.00|+00.00|+00.12")
        done = Action()

        constructed_plan = [teleport_bread, pick_bread, teleport_fridge, open_refrigerator, put_bread, close_refrigerator, done]
        return constructed_plan