

from ai2thor.video_controller import VideoController

if __name__ == "__main__":
    with VideoController() as vc:
        vc.play(vc.MoveAhead())
        vc.wait(5)
        vc.play(vc.MoveAhead())
        vc.export_video('thor.mp4')