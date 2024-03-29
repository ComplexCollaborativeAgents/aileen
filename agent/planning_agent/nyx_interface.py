from agent.base_agent import *
from agent.environment_model.actions import *
from agent.planning_agent.pddl_generator.domain_generator import PDDLDomainGenerator
from agent.planning_agent.pddl_generator.problem_generator import PDDLProblemGenerator
from agent.planning_agent.nyx import nyx
from agent.environment_model.actions import *
from agent.environment_model.state_parser import ThorStateParser
from random import randint
import time


class PlanningAgent(Agent):
    def __init__(self, world_server):
        super().__init__()
        self._current_state = dict()
        self.current_plan = list()
        self.required_obj_types = list()
        self.has_planned = False
        self._world = world_server
        self.reachable_positions = self._world.get_reachable_positions()
        self._goal = None
        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

    def get_next_action(self, current_state = None, goal_condition: str = ""):
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

            # pred_goal_condition = convert_nl_to_pddl(goal_condition)
            self.current_plan = self.plan(current_state, self._goal)
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

    def plan(self, current_state, goal_condition: str = ""):
        self.current_state = current_state
        self.parser = ThorStateParser(self._world)
        domain_path = "agent/planning_agent/domain/temp_domain.pddl"
        problem_path = "agent/planning_agent/domain/temp_problem.pddl"
        plan_file_path = "agent/planning_agent/domain/plans/plan1_temp_problem.pddl"
        domain_name = "ai_thor"
        domain_generator = PDDLDomainGenerator(domain_path, domain_name)
        domain = domain_generator.generate(self._world, current_state, self.required_obj_types)

        problem_generator = PDDLProblemGenerator(problem_path, ["temp-problem", domain_name])
        problem = problem_generator.generate(self._world, current_state, goal_condition, self.required_obj_types)
        self.objects = problem.objects["interactable"]

        nyx.runner(domain_generator.path, problem_generator.path, ['-vv'])
        interim_plan = self.extract_verbose_plan(plan_file_path)

        current_plan = self.translate_plan(interim_plan)

        return current_plan


    def extract_verbose_plan(self, plan_file):
        output = open(plan_file).readlines()
        plan = list()
        for line in output:
            line = line.strip()
            if line[-2:] == "]]":
                continue
            elif line[-1] == "]":
                arr = line.split("\t")
                action = arr[-2]
                plan.append(action)

        return plan


    def translate_plan(self, plan):
        translated_plan = list()
        _holding = False
        for action in plan:
            if "teleport" in action:
                to_obj = self.get_grounded_obj_id(action.split(" ")[2].split("_")[1])
                t_action = TeleportGroundingAction(self.parser, self.current_state, self.reachable_positions, to_obj, _holding)

            elif "pick" in action:
                obj = self.get_action_object(action)
                _holding = True
                t_action = PickObjectAction(obj)

            elif "put_inside" in action:
                obj2 = self.get_action_object(action)
                obj1 = self.get_action_param_object(action)
                _holding = False
                t_action = PutInsideObjectAction(obj1, obj2)

            elif "put_on" in action:
                obj2 = self.get_action_object(action)
                obj1 = self.get_action_param_object(action)
                _holding = False
                t_action = PutOnObjectAction(obj1, obj2)

            elif "put" in action:
                obj = self.get_action_action(action)
                _holding = False
                t_action = PutObjectAction(obj)

            elif "open" in action:
                obj = self.get_action_object(action)
                t_action = OpenObjectAction(obj)

            elif "close" in action:
                obj = self.get_action_object(action)
                t_action = CloseObjectAction(obj)

            translated_plan.append(t_action)
        return translated_plan


    def get_grounded_obj_id(self, given_obj):
        for obj in self.objects:
            if obj.lower() == given_obj:
                return obj


    def get_action_object(self, action):
        temp = action.split(" ")[0]
        action_obj = temp.split("_")[-1]

        return self.get_grounded_obj_id(action_obj)


    def get_action_param_object(self, action):
        param_obj = action.split(" ")[1]

        return self.get_grounded_obj_id(param_obj)

    def set_goal(self, goal):
        self._goal = goal

    def run(self):
        done = Action()
        self._current_state = self._world.execute_action(done.to_interface())
        self._current_state = self._world.execute_action(done.to_interface())
        while not self._goal:
            #print('running')
            pass

        self._logger.debug(f"Assigned a goal; planning; GOAL = {self._goal}")
        while self._goal:
            action = self.get_next_action(self._current_state, self._goal)
            if action is None:
                break
            self._current_state = self._world.execute_action(action)
            print(self._current_state["errorMessage"])

    def process_utterance(self, utterance):
        json_utterance = super().process_utterance(utterance)
        if json_utterance['INTENT'] == 'request':
            goal = self.ground_utterance(json_utterance)
            self._logger.debug('generated goal: {}'.format(goal))
            self.set_goal(goal)
        if self._goal:
            return "OK."

    def ground_utterance(self, json_utterance):
        for key in json_utterance:
            if key != 'INTENT':
                action = json_utterance[key]

        grounded_objects = {}
        grounded_relations = {}
        required_types = list()
        type = action['TYPE']
        for key in action:
            if 'obj' in key:
                grounded_objects[key], obj_type = self.ground_object(action[key])
                required_types.append(obj_type)
        for key in action:
            if 'rel' in key:
                grounded_relations[key] = self.ground_relation(action[key], grounded_objects)

        self.elaborate_relations(grounded_objects, grounded_relations)
        self.required_obj_types = required_types
        return self.compile_relations(grounded_relations)

    def compile_relations(self,ground_relations):
        compilation = "(and {})"
        clauses = ""
        for rel in ground_relations:
            clauses = clauses + " " + ground_relations[rel]
        return compilation.format(clauses)

    def ground_object(self, obj_json):
        self._logger.debug("grounding object: {}".format(obj_json))
        for obj_instance in self._current_state["objects"]:
            if obj_instance['objectType'].lower() == obj_json['TYPE'].lower():
                self._logger.debug("found object instance: {}".format(obj_instance['objectId']))
                return obj_instance['objectId'], obj_instance['objectType']



    def ground_relation(self, rel_json, grounded_objects):
        self._logger.debug("grounding relation: {}".format(rel_json))
        rel_instance = "({} {} {})".format(rel_json['TYPE'],
                                           grounded_objects[rel_json['ARG2']],
                                           grounded_objects[rel_json['ARG1']])
        return rel_instance

    def elaborate_relations(self, grounded_objects, grounded_relations):
        ### if grounded relations contain objects that are openable, add close predicate to revert them to their default state

        for object in grounded_objects:
            obj_id = grounded_objects[object]
            for w_object in self._current_state["objects"]:
                if w_object['objectId'] == obj_id:
                    if w_object['openable']:
                        key = "rel:{}".format(randint(100,1000))
                        grounded_relations[key] = "(closed {})".format(obj_id)
        print(grounded_relations)
