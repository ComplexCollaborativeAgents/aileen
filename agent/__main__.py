import time

<<<<<<< HEAD
from agent.planning_agent.nyx_interface import PlanningAgent
=======
from agent.planning_agent.nyx_agent import PlanningAgent
from agent import BaseAgent
from AgentServer import AgentServer
<<<<<<< HEAD
>>>>>>> 138823d2 (added server client integration for the instructor chat window)
=======
>>>>>>> 138823d2 (added server client integration for the instructor chat window)
from world.WorldServer import WorldServer
from BaseAgent import *
import settings
import jsonrpclib
import logging, coloredlogs
logger = logging.getLogger(__name__)
coloredlogs.install(level='DEBUG', logger=logger)

goal = "put bread in the refrigerator and close the door"

def create_connection_with_world():
    url = 'http://{}:{}'.format(settings.WORLD_HOST, settings.WORLD_PORT)
    logging.info("connecting to world server at host: {}, port: {}".format(settings.WORLD_HOST, settings.WORLD_PORT))
    server = jsonrpclib.jsonrpc.ServerProxy(url)
    return server
def initialize(world_server):
    world_server.execute_action({"action": 'Done'})
    event = world_server.execute_action({"action": 'Done'})

    return event
def create_and_run_agent_server(agent):
    server = AgentServer(agent)
    server.run_in_background()

def create_and_run_agent_server(agent):
    server = AgentServer(agent)
    server.run_in_background()

def execute_planning_agent(world_server):
    agent = PlanningAgent(world_server)
    action = None
    event = initialize(world_server)
    while True:
        action = agent.get_next_action(event, goal)
        if action is None:
            break
        event = world_server.execute_action(action)
        print(event["agent"])
        print(event["errorMessage"])


def execute_random_actions(world_server):
    agent = Agent()
    event = None
    for i in range(1, 100):
        print(i)
        action = agent.choose_action(event)
        logger.info("executing action: {}".format(ACTION_ROTATE_RIGHT))
        event = world_server.execute_action({"action": ACTION_ROTATE_RIGHT, "degrees": 90})
        # event = world_server.execute_action({"action": ACTION_MOVE_AHEAD})
        # print(event)
        print(event["agent"])
        break

def execute_keyboard_actions(world_server):
    import curses
    screen = curses.initscr()
    screen.keypad(1)

    ACTION_MAP = {
        curses.KEY_UP: ACTION_MOVE_AHEAD,
        curses.KEY_DOWN: ACTION_MOVE_BACK,
        curses.KEY_LEFT: ACTION_MOVE_LEFT,
        curses.KEY_RIGHT: ACTION_MOVE_RIGHT,
        114: ACTION_ROTATE_RIGHT,
        108: ACTION_ROTATE_LEFT
    }

    while True:
        arrow_key = curses.initscr().getch()
        if arrow_key in ACTION_MAP:
            world_server.execute_action(ACTION_MAP[arrow_key])
        else:
            print(arrow_key)
        continue


if __name__ == '__main__':
    world_server = create_connection_with_world()
    agent = Agent()
    create_and_run_agent_server(agent)
    logger = logging.getLogger(__name__)
    coloredlogs.install(level='DEBUG', logger=logger)
    while True:
        pass
    execute_planning_agent(world_server)
