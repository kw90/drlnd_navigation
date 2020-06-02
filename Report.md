# Description of the Implementation

This document describes the implementation for training an reinforcement
learning (RL) agent to solve the `Banana` Unity Environment from the Deep
Reinforcement Learning Nanodegree on Udacity. It includes a detailed description
of the learning algorithm with the used hyperparameters, the performance over
2000 episodes and concrete ideas for future work to improve the agent's
performance.

## Agent & Environment

As described in [[1]](#udacity-drlnd-repo), the provided environment is a large
and square world built with Unity. The goal is to collect as many yellow bananas
as possible, while avoiding blue bananas on the way.

![Trained Agent](./gifs/trained-1-unity.gif)

The learning agent operates in an initially unknown environment. By interacting with the
environment, the agent becomes more competent than its initial knowledge alone
might allow. Learning modifies the agent's components to bring them into
closer agreement with the available feedback information. Given this feedback,
the agent has to learn how to select the best action given a state.

### Task Environment

To design a rational agent, we have to specify the task environment. The
environment in which the agent is acting, is
- partially observable
- deterministic
- episodic
- static
- continuous
- single agent

As the performance measure, we define the average score collected over 100
consecutive episodes. If that average measure is above +13, the environment is
considered solved.

The agent percepts it's environment through a 37 dimensional vector. This vector
contains the agent's velocity and a ray-based perception of objects around
the agent's forward direction.

Interaction with the environment are available to the agent in the form of four
discrete actions that are
- move forward: `0`
- move backward: `1`
- turn left: `2`
- turn right: `3`


## Learning Algorithm


### Hyperparameters

| Name     | Value | Description |
| -------- | ----- | ----------- |
| max timesteps | 1000 | Maximum number of timesteps per episode |
|  |  |  |
| learning rate | 0.0005 | The learning rate used by the Adam optimizer |
| initial exploration | 1 | Initial value of ε in ε-greedy exploration |
| final exploration | 0.01 | Final value of ε in ε-greedy exploration |
| final exploration frame | 459000 | Number of frames over which the initial value of ε is monotonically decreased to its final value |
| replay start size | 4000 | Uniform random policy is run for this number of frames before learning starts


### Agent Performance

![Agent Learning](./gifs/training-1-cropped.gif)
![Reward Plot](./figures/reward-plot.png)


## Future Work

- Add all the six extensions that were combined in the 


## Sources

<a name="udacity-drlnd-repo">[1]</a>: *Navigation Project README*. Deep Reinforcement Learning Nanodegree GitHub
  repository.
  Retrieved 1 June 2020, from
  https://github.com/udacity/deep-reinforcement-learning/blob/master/p1_navigation/README.md#project-1-navigation.

<a name="dqn-nature-2015">[2]</a>: Mnih, Volodymyr, et al. "Human-level control
through deep reinforcement learning." Nature 518.7540 (2015): 529-533.

<a name="rainbow-aaai-2015">[3]</a>: Hessel, Matteo, et al. "Rainbow: Combining improvements in deep reinforcement learning." Thirty-Second AAAI Conference on Artificial Intelligence. 2018.
