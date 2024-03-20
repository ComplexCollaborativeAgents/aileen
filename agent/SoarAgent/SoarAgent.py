import settings
import socket
from contextlib import closing
import coloredlogs, logging, sys, os
import time

from agent.SoarAgent.InputWriter import InputWriter
from agent.SoarAgent.OutputReader import OutputReader

sys.path.append(settings.SOAR_PATH)
print(sys.path)
from threading import Thread


try:
    import Python_sml_ClientInterface as sml
except ValueError as e:
    logging.fatal("[soar_agent] :: Cannot find local soar installation")
    sys.exit()

class SoarAgent(object):
    def __init__(self, world_server, kernel_port=None, agent_params={}):
        self._logger = logging.getLogger(__name__)
        self._world_server = world_server
        print(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

        self.setup_soar_agent()
        self.init_state_maintenance_data_structures()

    def init_state_maintenance_data_structures(self):
        self.stop_requested = False
        self._agent_thread = None
        self._is_running = False
        self._wmes_to_delete = []

    def setup_soar_agent(self):
        self._kernel = self.create_kernel(kernel_port=None)
        self._agent = self.create_agent(settings.SOAR_AGENT_NAME)
        self._agentFilepath = settings.SOAR_AGENT_PATH
        self.load_agent_rules(self._agentFilepath)
        self._input_link = self._agent.GetInputLink()
        self._output_link = self._agent.GetOutputLink()
        self._input_writer = InputWriter(self._world_server, self)
        self._output_reader = OutputReader(self._world_server, self)


    def create_kernel(self, kernel_port):
        if kernel_port:
            soar_kernel_port = kernel_port
        else:
            soar_kernel_port = find_free_port()
        kernel = sml.Kernel.CreateKernelInNewThread(soar_kernel_port)
        # kernel = sml.Kernel.CreateKernelInCurrentThread()
        if not kernel or kernel.HadError():
            self._logger.error("error creating kernel: " + kernel.GetLastErrorDescription())
            exit(1)
        self._logger.info("created a soar kernel listening to port {}".format(soar_kernel_port))
        return kernel

    def create_agent(self, agent_name):
        agent = self._kernel.CreateAgent(agent_name)
        if not agent:
            self._logger.error("error creating agent: " + self.kernel.GetLastErrorDescription())
            exit(1)
        return agent

    def load_agent_rules(self, agent_file):
        self._logger.info("loading agent at %s" % agent_file)
        dirname = os.path.dirname(__file__)
        path = os.path.join(dirname, agent_file)
        self._agent.LoadProductions(path)

    def run_soar_java_debugger(self):
        self._agent.SpawnDebugger(self._kernel.GetListenerPort())

    def register_output_callback(self, function, caller_object=None):
        self._agent.RegisterForRunEvent(sml.smlEVENT_AFTER_OUTPUT_PHASE, function, caller_object, True)

    def run_till_output(self):
        self._agent.RunSelfTilOutput()

    def run_forever(self):
        self._agent.RunSelfForever()

    def get_input_link(self):
        return self._input_link

    def get_output_link(self):
        return self._output_link

    def commit(self):
        self._agent.Commit()

    def shutdown(self):
        self.stop_requested = True
        self._agent.KillDebugger()
        self._kernel.Shutdown()

    def quit(self):
        self.stop_requested = True
        self._agent.KillDebugger()

    def check_for_incoming_events(self):
        self._kernel.CheckForIncomingEvents()

    def execute_command(self, command):
        time.sleep(settings.SOAR_SLEEP_TIME)
        self._agent.ExecuteCommandLine(command)

    def set_time(self, week, day):
        self._input_writer.set_time = {'week': week, 'day': day}

    def start(self):
        if self._is_running:
            return
        self._is_running = True
        self._agent_thread = Thread(target=self.execute_command, args=("run",))
        self._agent_thread.daemon = True
        self._agent_thread.start()
        self._logger.info("spun-off agent thread.")

        if settings.SOAR_DEBUG:
            self._logger.info("starting soar debugger")
            self.run_soar_java_debugger()

    def stop(self):
        self.stop_requested = True

    def step(self):
        self.execute_command("step")

    def stop_agent_if_requested(self):
        if self.stop_requested is True:
            self._logger.info("[soar_agent] :: stopping agent")
            self.execute_command("stop")
            self._is_running = False
            self.stop_requested = False

    def get_number_of_commands(self):
        return self._agent.GetNumberCommands()

    def destroy_wme_on_list(self):
        # logging.debug("[soar_agent] :: wmes to be destroyed {}".format(self._wmes_to_delete))
        if len(self._wmes_to_delete) > 0:
            for wme in self._wmes_to_delete:
                if wme is not None:
                    # logging.debug("[soar_agent] :: destroying wme {}".format(wme.GetValueAsString()))
                    self._agent.DestroyWME(wme)
            self._wmes_to_delete = []

    def delete_all_children(self, id):
        logging.debug("[input_writer] :: deleting children of {}".format(id.GetValueAsString()))
        if id.GetNumberChildren() is not None:
            for i in range(0, id.GetNumberChildren()):
                child = id.GetChild(i)
                self._wmes_to_delete.append(child)
                # logging.debug(
                #     "[soar_agent] :: added {} {} {} child wme to destroy list".format(i, child.GetAttribute(),child.GetValueAsString()))


def update(mid, this_agent, agent, message):
    this_agent.stop_agent_if_requested()
    this_agent._output_reader.read_output()
    this_agent._input_writer.generate_input()
    this_agent.destroy_wme_on_list()


def find_free_port():
    """Source: https://stackoverflow.com/a/45690594."""
    with closing(socket.socket(socket.AF_INET, socket.SOCK_STREAM)) as s:
        s.bind(('', 0))
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        return s.getsockname()[1]

