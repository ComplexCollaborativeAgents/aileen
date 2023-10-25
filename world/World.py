import logging, coloredlogs
from ai2thor.controller import Controller
class World:
    def __init__(self):
        self._controller = Controller(
            agentMode="default",
            visibilityDistance=1.5,
            scene="FloorPlan212",

            gridSize=0.25,
            snapToGrid=True,
            rotateStepDegrees=90,

            renderDepthImage=False,
            renderInstanceSegmentation=False,

            width=300,
            height=300,
            fieldOfView=90
        )

        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

    def execute_action(self, action):
        self._logger.info("executing action request: {}".format(action))
        event = self._controller.step(action=action)
        return event.metadata
