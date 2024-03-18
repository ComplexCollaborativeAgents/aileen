from agent.BaseAgent import *
from agent.environment_model.actions import *
from agent.planning_agent.pddl_generator.domain_generator import PDDLDomainGenerator
from agent.planning_agent.pddl_generator.problem_generator import PDDLProblemGenerator
from agent.capabilities.llm_translator.translate import convert_nl_to_pddl
import time

class PlanningAgent(Agent):
    def __init__(self):
        super().__init__()
        self.current_plan = list()
        self.has_planned = False

    def get_next_action(self, world, current_state = None, goal_condition: str = ""):
        can_plan = True
        if len(self.current_plan) == 0 and not self.has_planned:
            time.sleep(2.0)
            if current_state is None:
                can_plan = False
                print("Can not construct a plan as current state info not provided")
            if goal_condition == "":
                can_plan = False
                print("Please provide a command for the robot")

            if not can_plan:
                print("Plan can't be generated")
                return None

            pred_goal_condition = convert_nl_to_pddl(goal_condition)
            self.current_plan = self.plan(world, current_state, pred_goal_condition)
            self.has_planned = True

        if len(self.current_plan) == 0:
            return None

        return self.current_plan.pop(0).to_interface()

    """def plan(self):
        print("plan for picking bread and putting it in the fridge")
        teleport_bread = TeleportAction({'x': 0.0, 'y': 0.9799999594688416, 'z': 1.75}, {'x': 0, 'y': 270, 'z': 0})
        pick_bread = PickObjectAction("Bread|-00.92|+00.99|+02.27")
        teleport_fridge = TeleportAction({'x': 0.0, 'y': 0.9799999594688416, 'z': 0.0}, {'x': 0, 'y': 270, 'z': 0})
        open_refrigerator = OpenObjectAction("Fridge|-01.00|+00.00|+00.12")
        put_bread = PutObjectAction("Fridge|-01.00|+00.00|+00.12")
        close_refrigerator = CloseObjectAction("Fridge|-01.00|+00.00|+00.12")
        done = Action()

        constructed_plan = [teleport_bread, pick_bread, teleport_fridge, open_refrigerator, put_bread, close_refrigerator, done]
        return constructed_plan"""

    def plan(self, world, current_state, goal_condition: str = ""):
        domain_path = "agent/planning_agent/domain/temp_domain.pddl"
        problem_path = "agent/planning_agent/domain/temp_problem.pddl"
        domain_name = "ai_thor"
        domain_generator = PDDLDomainGenerator(domain_path, domain_name)
        domain = domain_generator.generate(world, current_state)

        problem_generator = PDDLProblemGenerator(problem_path, ["bread_in_refigerator", domain_name])
        problem = problem_generator.generate(world, current_state, goal_condition)
