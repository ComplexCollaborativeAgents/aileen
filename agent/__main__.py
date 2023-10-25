import agent.BaseAgent
from world.WorldServer import WorldServer
from BaseAgent import Agent
import settings
import jsonrpclib
import logging, coloredlogs
logger = logging.getLogger(__name__)
coloredlogs.install(level='DEBUG', logger=logger)


def create_connection_with_world():
    url = 'http://{}:{}'.format(settings.WORLD_HOST, settings.WORLD_PORT)
    logging.info("connecting to world server at host: {}, port: {}".format(settings.WORLD_HOST, settings.WORLD_PORT))
    server = jsonrpclib.jsonrpc.ServerProxy(url)
    return server

def execute_random_actions(world_server):
    agent = Agent()
    event = None
    for i in range(1, 100):
        print(i)
        action = agent.choose_action(event)
        logger.info("executing action: {}".format(action))
        event = world_server.execute_action(action)

def execute_keyboard_actions(world_server):
    import curses
    screen = curses.initscr()
    screen.keypad(1)

    ACTION_MAP = {
        curses.KEY_UP: agent.BaseAgent.ACTION_MOVE_AHEAD,
        curses.KEY_DOWN: agent.BaseAgent.ACTION_MOVE_BACK,
        curses.KEY_LEFT: agent.BaseAgent.ACTION_MOVE_LEFT,
        curses.KEY_RIGHT: agent.BaseAgent.ACTION_MOVE_RIGHT,
        114: agent.BaseAgent.ACTION_ROTATE_RIGHT,
        108: agent.BaseAgent.ACTION_ROTATE_LEFT
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
    logger = logging.getLogger(__name__)
    coloredlogs.install(level='DEBUG', logger=logger)
    #execute_random_actions(world_server)
    execute_keyboard_actions(world_server)
