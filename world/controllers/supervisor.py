from ai2thor.controller import Controller



class Supervisor:
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

    def rotateRight(self):
        event = self._controller.step(action="RotateRight")
        metadata = event.metadata
        print(event, event.metadata.keys())

if __name__ == '__main__':
    supervisor = Supervisor()
    while True:
        supervisor.rotateRight()

