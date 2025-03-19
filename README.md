# AILEEN
AILEEN is an embodied agent integrated with [AI2-Thor](https://ai2thor.allenai.org). It implements as hybrid AI architecture and brings large language models together with AI planning frameworks.

Relevant materials:
[ICAPS 2024 paper](https://openreview.net/forum?id=62frmxeAPp) | [Demonstration Video](https://drive.google.com/file/d/13XoLwNj8V5YnO5YavilxhbEbGf3UtXjk/view)



## Getting started

Create the 'elaborate' conda environment.
```
conda env create -f environment.yml
```

Update your bash_profile

```
gedit ~/.bash_profile
```
Add this line to your bash_profile
```
export PYTHONPATH="/home/smohan/EMBRACE/elaborate"
```
Save and exit.
```
source ~/.bash_profile
```

Using an IDE such as pycharm for development is highly recommended.

## Run world

```
python world
```
This should bring up a window that shows what the agent is viewing.

## Run agent

```
python agent
```

This should run a dummy agent that selects and applies a random action in the environment and records the updated state. 
