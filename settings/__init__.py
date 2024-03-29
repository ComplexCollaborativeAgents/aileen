import os
from os import path
CI = 'GITLAB_CI' in os.environ
OS_ROOT_PATH = path.abspath(os.sep)
ROOT_PATH = path.join(path.dirname(path.dirname(path.abspath(__file__))))

## Nyx
NYX_HOME = path.join(ROOT_PATH, 'agent', 'planning_agent', 'nyx')


## SOAR
SOAR_PATH = path.join(OS_ROOT_PATH, 'Library', 'Soar-Release-9.6.2', 'SoarSuite', 'SoarSuite_9.6.2-Multiplatform', 'bin')
SOAR_DEBUGGER_PATH = path.join(OS_ROOT_PATH, 'Library', 'Soar-Release-9.6.2', 'SoarSuite', 'SoarSuite_9.6.2-Multiplatform', 'bin', 'SoarJavaDebugger.jar')
SOAR_AGENT_PATH = path.join(ROOT_PATH, 'agent', 'SoarAgent', 'soar', 'load.soar')
SOAR_AGENT_NAME = 'aileen-elaborate'
SOAR_DEBUG = True
SOAR_SLEEP_TIME = 0.001

##JAVA
JAVA_HOME = path.join(OS_ROOT_PATH, 'opt', 'homebrew', 'opt', 'openjdk@11', 'bin')

WORLD_HOST = 'localhost'
WORLD_PORT = 30000
AGENT_HOST = 'localhost'
AGENT_PORT = 40001
AGENT_SERVER_PORT = 50001
