import logging, coloredlogs
from ai2thor.controller import Controller
import cv2
class World:
    def __init__(self):
        self._controller = Controller(
            agentMode="default",
            visibilityDistance=1.5,
            scene="FloorPlan12",

            gridSize=0.25,
            snapToGrid=True,
            rotateStepDegrees=90,

            renderDepthImage=False,
            renderInstanceSegmentation=False,

            width=1000,
            height=1000,
            fieldOfView=90
        )

        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger=self._logger)

        evt = self._controller.step(action="SetTopLevelView", topView=True)
        event = self._controller.step(
            action="AddThirdPartyCamera",
            position=dict(x=0.9, y=2.7, z=-0.7),
            rotation=dict(x=90, y=0, z=0),
            fieldOfView=90
        )
        third_party_frame = event.third_party_camera_frames[0]
        cv2.imwrite('image.png', third_party_frame)
        img = cv2.imread('image.png', cv2.IMREAD_ANYCOLOR)
        #cv2.imshow("camera", img)

    def execute_action(self, action):
        self._logger.info("executing action request: {}".format(action))
        event = self._controller.step(action=action)
        return event.metadata
