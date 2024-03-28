# Nyx - a new PDDL+ planner written in Python

Nyx is a PDDL+ parser and planner written in python with a focus on simplicity. It is a discretization-based planner that approximates the continuous system dynamics using uniform time steps (Δt) and step functions.


This work was initially based on the classical parser and planner written by PUCRS (https://github.com/pucrs-automated-planning/pddl-parser).

## Source
- [nyx.py](nyx.py): Main Runner
- [planner.py](planner.py): main planning loop and associated functions
- [PDDL.py](PDDL.py): PDDL parser
- [heuristic_functions.py](heuristic_functions.py): heuristic function definitions used in GBFS and A* Searches
- [simulator.py](simulator.py): (Work in Progress) PDDL+ plan simulator
- [semantic_attachments](semantic_attachments/):
  - [semantic_attachment.py](semantic_attachments/semantic_attachment.py): implementation of  semantic attachments (external functions)
- [syntax](syntax/) folder with PDDL object classes and supporting elements:
  - [action.py](syntax/action.py) 
  - [event.py](syntax/event.py) 
  - [process.py](syntax/process.py)
  - [state.py](syntax/state.py)
  - [visited_state.py](syntax/visited_state.py)
  - [constants.py](syntax/constants.py)
  - [plan.py](syntax/plan.py)
  - [trace.py](syntax/trace.py)
- [compiler](compiler/) folder with JIT compiler classes:
  - [JIT.py](compiler/JIT.py)
  - [HappeningMixin.py](compiler/HappeningMixin.py)
  - [preconditions_tree.py](compiler/preconditions_tree.py)
- [ex](ex/) folder with PDDL domains:
  - [Car](ex/car)
  - [Sleeping Beauty](ex/sleeping_beauty/)
  - [Cartpole](ex/cartpole/)
  - [Vending Machine](ex/vending_machine/)
  - [Powered Descent](ex/1D-powered-descent/)
  - [Convoys](ex/convoys_mt/)
  - [Linear Generator](ex/linear-generator/)
  - [Non-Linear Generator](ex/non-linear-generator/)
  - [Linear Generator (with processes)](ex/lg_process/)
  - [Solar Rover](ex/solar-rover/)
  - [Non-Linear Solar Rover](ex/non-linear-solar-rover/)
  - [Planetary Lander](ex/planetary/)
  - [Angry/Science Birds](ex/sb/)
  - [Non-Temporal](ex/non-temporal/) folder with non-temporal PDDL domains:
	  - [Dinner](ex/non-temporal/dinner/)
	  - [Blocks World](ex/non-temporal/blocksworld/)
	  - [Dock Worker Robot](ex/non-temporal/dwr/)
	  - [Travelling Salesman Problem](ex/non-temporal/tsp/)
    - [Driving](ex/non-temporal/driving/)
    - [Minecraft](ex/non-temporal/minecraft/)

## Planner execution
```Shell
python -B nyx.py ex/car/car.pddl ex/car/pb01.pddl -t:1
```

use flag ```-h``` for a usage and planner option information.

## Current limitations of our planner
- No support for object subtypes
