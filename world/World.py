import logging, coloredlogs
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
        self._controller.step(action='Done')

    def execute_action(self, action):
        self._logger.info("executing action request: {}".format(action))
        event = self._controller.step(**action)
        self.display_frame(self.get_topdown_map_view())
        return event.metadata

    def display_frame(self, im, wait=None, height=896, title=None):
        def rgb_to_bgr(f):
            return np.stack([f[:, :, 2], f[:, :, 1], f[:, :, 0]], axis=-1).astype(np.uint8)

        ready_ims = []

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
        # self._controller.step("HideVisualizedPath")
        return event.third_party_camera_frames[-1]

    def get_recent_event(self):
        _event = self._controller.last_event()
        return _event.metadata

    def get_objects(self, _event=None):
        if _event is None:
            _event = self.get_recent_event()

        objects = _event.metadata["objects"]
        return objects

    def get_object_ids(self, _event=None):
        objects = self.get_objects(_event)

        object_IDs = dict()

        for obj in objects:
            _type = obj["objectType"]
            if _type not in object_IDs:
                object_IDs[_type] = list()

            object_IDs[_type].append(obj["objectId"])

        return object_IDs

    def get_object(self, objectID, _event=None):
        objects = self.get_objects(_event)

        for obj in objects:
            if objectID == obj["objectId"]:
                return obj

        return None

    def get_object_location(self, objectID, _event=None):
        obj = self.get_object(objectID, _event)

        return obj["position"]

    def get_receptacle_objects(self, objectID, _event=None):
        obj = self.get_object(objectID, _event)

        return obj["receptacleObjectIds"]

    def get_all_object_location(self, _event=None):
        objects = self.get_objects(_event)
        locations = dict()
        for obj in objects:
            obj_id = obj["objectId"]
            locations[obj_id] = obj["position"]
            locations[obj_id]["receptacle"] = False
            for receptacle_obj_id in obj["receptacleObjectIds"]:
                locations[receptacle_obj_id] = obj["position"]
                locations[receptacle_obj_id]["receptacle"] = True

        return locations

    def get_agent_information(self, _event=None):
        if _event is None:
            _event = self.get_recent_event()

        return _event["agent"]

    def get_agent_location(self, _event=None):
        _agent = self.get_agent_information(_event)

        return _agent["position"]


    def get_reachable_positions(self):
        positions = self._controller.step(
            action="GetReachablePositions"
        )
        return positions.metadata["actionReturn"]
    