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

    def execute_action(self, action):
        event = self._controller.step(action=action)
        metadata = event.metadata
        #print(event, event.metadata)
        #return metadata
        return event

if __name__ == '__main__':
    supervisor = World()
    while True:
        supervisor.rotateRight()