import logging, coloredlogs
from agent.environment_model import actions
import random


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
                pass

            if commandName == 'language':
                self.process_language_command(commandID)

            if commandName == 'interaction':
                self.process_repsonse(commandID)


    def process_action_description(self, commandID):
        action_dict = {}
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'name':
                # if child.GetValueAsString() == 'teleport':
                #     self._logger.debug('received teleport command')
                #     self.process_teleport_command(commandID)
                if child.GetValueAsString() == 'go-to':
                    self._logger.debug('received goto')
                    self.process_goto_command(commandID)
                if child.GetValueAsString() == 'pick-up':
                    self._logger.debug('received pick-up')
                    self.process_pickup_command(commandID)
                if child.GetValueAsString() == 'open':
                    self._logger.debug('received open')
                    self.process_open_command(commandID)
                if child.GetValueAsString() == 'close':
                    self._logger.debug('received close')
                    self.process_close_command(commandID)
                if child.GetValueAsString() == 'put':
                    self._logger.debug('received open')
                    self.process_put_command(commandID)


    def process_goto_command(self, commandID):
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'id':
                id = child.GetValueAsString()
        action_def = actions.GetInteractablePoses(_objectID=id).to_interface()
        self._logger.debug('requesting {}'.format(action_def))
        metadata = self._world_server.execute_action(action_def)
        possible_pose = random.choice(metadata['actionReturn'])
        position = dict(x=possible_pose['x'],y=possible_pose['y'],z=possible_pose['z'])
        action = actions.TeleportAction(_position=position,
                                _rotation=possible_pose['rotation'],
                                _horizon=possible_pose['horizon'],
                                _standing=possible_pose['standing']).to_interface()
        self._world_server.execute_action(action)
        commandID.AddStatusComplete()

    def process_pickup_command(self, commandID):
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'id':
                id = child.GetValueAsString()
        action = actions.PickObjectAction(_objectID=id).to_interface()
        self._logger.debug('requesting {}'.format(action))
        self._world_server.execute_action(action)
        commandID.AddStatusComplete()


    def process_close_command(self, commandID):
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'id':
                id = child.GetValueAsString()
        action = actions.CloseObjectAction(_objectID=id).to_interface()
        self._logger.info('requesting {}'.format(action))
        self._world_server.execute_action(action)
        commandID.AddStatusComplete()


    def process_close_command(self, commandID):
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'id':
                id = child.GetValueAsString()
        action = actions.CloseObjectAction(_objectID=id).to_interface()
        self._logger.info('requesting {}'.format(action))
        self._world_server.execute_action(action)
        commandID.AddStatusComplete()

    def process_put_command(self, commandID):
        for i in range(0, commandID.GetNumberChildren()):
            child = commandID.GetChild(i)
            if child.GetAttribute() == 'id':
                id = child.GetValueAsString()
        action = actions.PutObjectAction(_objectID=id).to_interface()
        self._logger.info('requesting {}'.format(action))
        self._world_server.execute_action(action)
        commandID.AddStatusComplete()
