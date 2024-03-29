import coloredlogs, logging
import socket
from threading import Thread
import settings
from jsonrpclib.SimpleJSONRPCServer import SimpleJSONRPCServer

class AgentServer:
    def __init__(self, agent, port=settings.AGENT_SERVER_PORT):
        self._port = port
        self._thread = None
        self._agent = agent
        self._host = socket.gethostbyname(settings.AGENT_HOST)
        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)
        self._logger.info("starting world server at host: {}, port: {}".format(self._host, self._port))
        self._server = SimpleJSONRPCServer((self._host, self._port))
        def process_utterance(nl_string):
            self._logger.info("processing nl {}".format(nl_string))
            return self._agent.process_utterance(nl_string)

        self._server.register_function(process_utterance, "process_utterance")

    def run(self):
        while True:
            self._logger.info("agent server started serving")
            self._server.serve_forever()

    def run_in_background(self):
        self._thread = Thread(target=self.run)
        self._thread.daemon = True
        self._thread.start()

def create_and_run_agent_server(agent):
    server = AgentServer(agent)
    server.run_in_background()