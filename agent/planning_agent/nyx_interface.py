from agent.BaseAgent import *
from agent.environment_model.actions import *
from agent.planning_agent.pddl_generator.domain_generator import PDDLDomainGenerator
from agent.planning_agent.pddl_generator.problem_generator import PDDLProblemGenerator
from agent.capabilities.llm_translator.translate import convert_nl_to_pddl
import time

class PlanningAgent(Agent):
    def __init__(self, world):
        super().__init__()
        self._current_state = dict()
        self.current_plan = list()
        self.has_planned = False
        self._goal = None
        self._world = world
        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

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
    def set_goal(self, goal):
        self._goal = goal

    def run(self):
        self._current_state = self._world.execute_action({"action": 'Done'})
        while not self._goal:
            self._current_state = self._world.execute_action({"action": 'Done'})
            #print('running')
            pass

        while self._goal:
            self._logger.debug("Assigned a goal; planning")
            self._current_state = self._world.execute_action({"action": 'Done'})
            action = self.get_next_action(self._world, event, self._goal)
            if action is None:
                break
            event = self._world.execute_action(action)
            print(event["agent"])
            print(event["errorMessage"])

    def process_utterance(self, utterance):
        json_utterance = super().process_utterance(utterance)
        print(json_utterance)
        if json_utterance['INTENT'] == 'request':
            goal = self.ground_utterance(json_utterance)
            self._logger.debug('generated goal: {}'.format(goal))
            self.set_goal(goal)

    def ground_utterance(self, json_utterance):
        for key in json_utterance:
            if key != 'INTENT':
                action = json_utterance[key]

        grounded_objects = {}
        grounded_relations = {}
        type = action['TYPE']
        for key in action:
            if 'obj' in key:
                grounded_objects[key] = self.ground_object(action[key])
        for key in action:
            if 'rel' in key:
                grounded_relations[key] = self.ground_relation(action[key], grounded_objects)

        return grounded_relations['rel:0']



    def ground_object(self, obj_json):
        self._logger.debug("grounding object: {}".format(obj_json))
        for obj_instance in self._current_state["objects"]:
            if obj_instance['objectType'].lower() == obj_json['TYPE'].lower():
                self._logger.debug("found object instance: {}".format(obj_instance['objectId']))
                return obj_instance['objectId']



    def ground_relation(self, rel_json, grounded_objects):
        self._logger.debug("grounding relation: {}".format(rel_json))
        rel_instance = "({} {} {})".format(rel_json['TYPE'],
                                           grounded_objects[rel_json['ARG1']],
                                           grounded_objects[rel_json['ARG2']])
        return rel_instance