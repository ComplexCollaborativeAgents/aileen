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


if __name__ == '__main__':
    world_server = create_connection_with_world()
    logger = logging.getLogger(__name__)
    coloredlogs.install(level='DEBUG', logger=logger)
    agent = Agent()
    event = None
    for i in range(1, 100):
        print(i)
        action = agent.choose_action(event)
        logger.info("executing action: {}".format(action))
        event = world_server.execute_action(action)