# Solving the DRLND Unity Navigation Environment

Train an agent to solve the Banana Unity Environment from the Deep Reinforcement
Learning Nanodegree on Udacity.

![Trained Agent +12 Score](./gifs/trained-1-unity.gif)
![Reward Plot Training 2000 Episodes](./figures/reward-plot.png)

The trained agent playing above achieved a score of +12. After 600 episodes of
training, the agent achieved an average score of +13 over 100 consecutive
episodes. The task was solved using a simple DQN architecture without
imporovements on the 37 dimensional state vector.

## Training

![Trained Agent +12 Score](./gifs/training-1-screen.gif)


## Prerequisites

- `conda` or `miniconda` (recommended)

## Install Environment

Create a `conda` environment called `drlnd_nav` with Python3.6 using the
following commands

```zsh
conda create --name drlnd_nav python=3.6
conda activate drlnd_nav
```

Next, run `make install` to install all requirements in the created `conda`
environment.

## Run the Code

Next, run `make start` to start the Jupyter notebook server and use your favorite
browser to navigate to
[http://localhost:8888/?token=abcd](http://localhost:8888/?token=abcd).

