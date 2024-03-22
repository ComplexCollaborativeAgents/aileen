import coloredlogs, logging
import socket
from threading import Thread
import time
import settings

from jsonrpclib.SimpleJSONRPCServer import SimpleJSONRPCServer
from jsonrpclib.SimpleJSONRPCServer import SimpleJSONRPCRequestHandler

class WorldServer:

    def __init__(self, world, port=settings.WORLD_PORT):
        self._quit = True
        self._port = port
        self._thread = None
        self._world = world
        self._host = socket.gethostbyname(settings.WORLD_HOST)
        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

        self._logger.info("starting world server at host: {}, port: {}".format(self._host, self._port))
        self._server = SimpleJSONRPCServer((self._host, self._port))


        def execute_action(action):
            self._logger.info("serving action request: {}".format(action))
            return self._world.execute_action(action)

        def get_reachable_positions():
            positions = self._world.get_reachable_positions()
            return positions

        def get_recent_event():
            event = self._world.get_recent_event()
            return event

        def get_interactable_pose(object_id):
            event = self._world.get_interactable_pose(object_id)
            return event


        self._server.register_function(execute_action, "execute_action")
        self._server.register_function(get_reachable_positions, "get_reachable_positions")
        self._server.register_function(get_reachable_positions, "get_recent_event")

        def get_interactable_pose(object_id):
            self._logger.info("serving get interactable pose request for object {}".format(object_id))
            return self._world.get_interactable_pose(object_id)


        self._server.register_function(execute_action, "execute_action")
        self._server.register_function(get_interactable_pose, "get_interactable_pose")

    def run(self):
        while True:
            self._logger.info("serving")
            self._server.serve_forever()


    def run_in_background(self):
        self._thread = Thread(target=self.run)
        self._thread.daemon = True
        self._thread.start()

