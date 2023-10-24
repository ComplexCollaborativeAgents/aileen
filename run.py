from world import ElaborateWorld
from agent import BaseAgent

def main():
    world = ElaborateWorld.World()
    agent = BaseAgent.Agent()
    event = None
    for i in range(1, 100):
        action = agent.choose_action(event)
        event = world.execute_action(action)



if __name__ == "__main__":
    main()
