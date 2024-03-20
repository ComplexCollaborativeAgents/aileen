import logging, coloredlogs

class OutputReader(object):
    def __init__(self, world_server, soar_agent):
        self._world_server = world_server
        self._soar_agent = soar_agent
        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

    def read_output(self):
        number_of_commands = self._soar_agent._agent.GetNumberCommands()
        for i in range(0, number_of_commands):
            commandID = self._soar_agent._agent.GetCommand(i)
            commandName = commandID.GetAttribute()

            if commandName == 'action':
                self.process_action_description(commandID)

            if commandName == 'language':
                self.process_language_command(commandID)

            if commandName == 'interaction':
                self.process_repsonse(commandID)


    def process_action_description(self, commandID):
        action_dict = {}
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'name':
                if child.GetValueAsString() == 'teleport':
                    pass
