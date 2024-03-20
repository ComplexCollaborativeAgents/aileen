from SoarAgent import SoarAgent, update
import time
import settings
import logging
import jsonrpclib
import os
os.environ["JAVA_HOME"] = settings.JAVA_HOME


def create_connection_with_world():
   url = 'http://{}:{}'.format(settings.WORLD_HOST, settings.WORLD_PORT)
   logging.info("connecting to world server at host: {}, port: {}".format(settings.WORLD_HOST, settings.WORLD_PORT))
   server = jsonrpclib.jsonrpc.ServerProxy(url)
   return server


if __name__ == '__main__':
   os.environ["JAVA_HOME"] = settings.JAVA_HOME
   world_server = create_connection_with_world()
   agent = SoarAgent(world_server=world_server)
   agent.register_output_callback(update, agent)

   agent.start()
   if settings.SOAR_DEBUG:
      agent.stop()

   while True:
      time.sleep(0.001)
