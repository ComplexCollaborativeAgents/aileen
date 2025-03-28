import logging, coloredlogs
import random
import time

from ai2thor.controller import Controller
import cv2
import numpy as np

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

        self._topview_camera = self.add_topview_camera()
        self._topview_image = None
        self._topview_camera_thread = None

        self.execute_action(dict(action='Done'))
        #self.display_frame(self.get_topdown_map_view())

    def add_topview_camera(self):
        event = self._controller.step({"action": "GetMapViewCameraProperties"})
        cam = event.metadata["actionReturn"].copy()
        cam["orthographicSize"] += 1
        self._controller.step({"action": "AddThirdPartyCamera", "skyboxColor": "white", **cam})

    def update_topview_camera_image(self, image, height = 896, title=None):
        image = self._rgb_to_bgr(image)
        image = cv2.resize(image, (int(round(height * image.shape[1] / image.shape[0])), height),
        interpolation=cv2.INTER_NEAREST)
        cv2.imshow("Top View", image)
        cv2.setWindowProperty("Top View", cv2.WND_PROP_TOPMOST, 1)
        cv2.setWindowTitle("Top View", title or "view")
        cv2.waitKey(1)



    def _rgb_to_bgr(self, f):
        return np.stack([f[:, :, 2], f[:, :, 1], f[:, :, 0]], axis=-1).astype(np.uint8)

    def execute_action(self, action):
        self._logger.info("executing action request: {}".format(action))
        event = self._controller.step(**action)
        #self.update_topview_camera_image(event.third_party_camera_frames[-1])
        return event.metadata

    def display_frame(self, im, wait=None, height=896, title=None):
        def rgb_to_bgr(f):
            return np.stack([f[:, :, 2], f[:, :, 1], f[:, :, 0]], axis=-1).astype(np.uint8)

        im = rgb_to_bgr(im)
        im = cv2.resize(
            im,
            (int(round(height * im.shape[1] / im.shape[0])), height),
            interpolation=cv2.INTER_NEAREST,
        )

        cv2.imshow("Top View", im)
        cv2.setWindowProperty("Top View", cv2.WND_PROP_TOPMOST, 1)
        cv2.setWindowTitle("Top View", title or "view")
        cv2.waitKey(1) & 0xFF == ord('0')


    def get_topdown_map_view(self):
        """Visualize a top-down map view of the environment
        # Parameters
        controller - An AI2-THOR controller
        """

        if len(self._controller.last_event.third_party_camera_frames) < 2:
            event = self._controller.step({"action": "GetMapViewCameraProperties"})
            cam = event.metadata["actionReturn"].copy()
            cam["orthographicSize"] += 1
            self._controller.step(
                {"action": "AddThirdPartyCamera", "skyboxColor": "white", **cam}
            )

        event = self._controller.step({"action": "Done"})
        self._controller.step("HideVisualizedPath")
        return event.third_party_camera_frames[-1]


    def get_recent_event(self):
        _event = self._controller.last_event()
        return _event.metadata


    def get_reachable_positions(self):
        positions = self._controller.step(
            action="GetReachablePositions"
        )
        return positions.metadata["actionReturn"]

    def get_interactable_poses(self, obj_id):
        poses = self._controller.step(
            action = "GetInteractablePoses",
            objectId = obj_id
        )

        return poses.metadata["actionReturn"]

