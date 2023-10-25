import time
from World import World
from WorldServer import WorldServer

def create_and_run_world_server(world):
    server = WorldServer(world)
    server.run_in_background()


if __name__ == "__main__":
    world = World()
    create_and_run_world_server(world)
    while True:
        time.sleep(0.001)