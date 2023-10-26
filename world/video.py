from ai2thor.controller import Controller
import random
#import matplotlib.pyplot as plt
from typing import Optional, Sequence, Dict
import cv2
import numpy as np
#import time


def display_frame(im, wait=None, height=448, title=None):
    def rgb_to_bgr(f):
        return np.stack([f[:, :, 2], f[:, :, 1], f[:, :, 0]], axis=-1).astype(np.uint8)

    ready_ims = []

    im = rgb_to_bgr(im)
    im = cv2.resize(
        im,
        (int(round(height * im.shape[1] / im.shape[0])), height),
        interpolation=cv2.INTER_NEAREST,
    )

    cv2.imshow("view", im)
    cv2.setWindowProperty("view", cv2.WND_PROP_TOPMOST, 1)
    cv2.setWindowTitle("view", title or "view")
    cv2.waitKey(1) & 0xFF == ord('0')


def get_topdown_map_view(
    controller: Controller, agent_path: Optional[Sequence[Dict[str, float]]] = None
):
    """Visualize a top-down map view of the environment

    # Parameters
    controller - An AI2-THOR controller
    agent_path - An optional list of agent positions of the form [{"x": x_pos, "y": y_pos, "z": z_pos}, ...]
    """

    if len(controller.last_event.third_party_camera_frames) < 2:
        event = controller.step({"action": "GetMapViewCameraProperties"})
        cam = event.metadata["actionReturn"].copy()
        cam["orthographicSize"] += 1
        controller.step(
            {"action": "AddThirdPartyCamera", "skyboxColor": "white", **cam}
        )

    event = controller.step({"action": "Done"})
    controller.step("HideVisualizedPath")
    return event.third_party_camera_frames[-1]
    pass


if __name__ == "__main__":
    controller = Controller(scene="FloorPlan1", height=500, width=500)

    random.seed(1)
    agent_path = [controller.last_event.metadata["agent"]["position"]]
    for _ in range(100):
        controller.step(
            random.choice(["MoveAhead", "MoveRight", "MoveLeft", "MoveBack"])
        )
        #agent_path.append(controller.last_event.metadata["agent"]["position"])

        display_frame(get_topdown_map_view(controller=controller, agent_path=agent_path))