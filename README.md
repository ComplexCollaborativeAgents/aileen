# ELABORATE



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
