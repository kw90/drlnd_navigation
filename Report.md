# Description of the Implementation

This document describes the implementation for training an reinforcement
learning (RL) agent to solve the `Banana` [Unity
ML-agents](https://github.com/Unity-Technologies/ml-agents) Environment from the
Deep Reinforcement Learning Nanodegree on Udacity. It includes a detailed
description of the learning algorithm with the used hyperparameters, the
performance over 2000 episodes and concrete ideas for future work to improve the
agent's performance.

## Agent & Environment

As described in [[1]](#udacity-drlnd-repo), the provided environment is a large
and square world built with Unity. The goal is to collect as many yellow bananas
as possible, while avoiding blue bananas on the way.

![Trained Agent](./gifs/trained-1-unity.gif)

The learning agent operates in an initially unknown environment. By interacting
with the environment, the agent becomes more competent than its initial
knowledge alone might allow. Learning modifies the agent's components to bring
them into closer agreement with the available feedback information. Given this
feedback, the agent has to learn how to select the best action given a state.

### Task Environment

To design a rational agent, we have to specify the task environment. The
environment in which the agent is acting, is
- partially observable
- deterministic
- episodic
- static
- continuous
- single agent

The environment rewards the agent with `+1` for collecting a yellow banana, and
a `-1` reward for a blue banana. As the performance measure, we define the
average score collected over 100 consecutive episodes. If that average measure
is above +13, the environment is considered solved.

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

### Deep Q-Network (DQN)

The learning algorithm implemented in this project follows the DQN value-based
method proposed in [[2]](#dqn-nature-2015), which showed human-level control
through deep reinforcement learning. This deep Q-network agent was able to
achieve a comparable level to that of a professional human games tester,
requiring only the raw pixel and game score information. To achieve that, they
replaced the linear function approximator by a nonlinear function approximator
(neural network), which they called the Q-network.

To make it suitable for training large neural networks without diverging due to
harmful correlations, [[2]](#dqn-nature-2015) further integrated two
improvements, named *experience replay* proposed by
[[3]](#experience-replay-1993) and using a separate network that stays fixed for
`C` updates to generate the targets. Experience replay reduces the possibly high
correlation between a sequence of experience tuples by storing experiences in a
*replay buffer* and sampling from it uniformly.

The paper in [[2]](#dqn-nature-2015) gives a good example to understand the
effects of strong correlations between samples.

>  For example, if the maximizing action is to move left then the training samples
>  will be dominated by samples from the left-hand side; if the maximizing action
>  then switches to the right then the training distribution will also switch. It
>  is easy to see how unwanted feedback loops may arise and the parameters could
>  get stuck in a poor local minimum, or even diverge catastrophically.

Using experience replay hence
- **allows for greater data efficiency**, as each step potentially used in many
  weight updates
- **breaks correlations and reduces variance of updates**, by randomizing the
  samples
- next data sample that parameters are trained on is **not** determined by current parameters


The second modification in [[2]](#dqn-nature-2015) aimed at making the algorithm
more stable compared to standard online Q-learning. An update that increases the
Q-value of time `t` also frequently increases the Q-value for all actions of
time `t+1` and hence also increases the target. Such online Q-learning methods
can lead to oscillations or divergence of the policy. Adding a delay between the
time an update to `Q` is made and the time the update affects the targets, makes
such divergence or oscillations more unlikely. Therefore, a target network `Q^`
is introduced to compute the targets `y` and updated only every `C` updated to
`Q`.


### Algorithm

+ TODO: Add algo description
+ TODO: Add NN architecture


### Implementation

+ TODO: Add more details

| File | Description |
| ---- | ----------- |
| `model.py` | Python3 file implementing the QNetwork with PyTorch |
| `dqn_agent.py` | Python3 file implementing the DQN agent together with a replay buffer |
| `kW_Solution-Navigation.ipynb` | Jupyter Notebook to train the agent and setting hyperparameters |


### Hyperparameters

+ TODO: Add rest of the hyperparameters

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

+ TODO: Add rest of the future work ideas

- Add all the six extensions that were combined in the [[4]](#rainbow-aaai-2015)


## Sources

<a name="udacity-drlnd-repo">[1]</a>: *Navigation Project README*. Deep
Reinforcement Learning Nanodegree GitHub repository. Retrieved 1 June 2020,
from
https://github.com/udacity/deep-reinforcement-learning/blob/master/p1_navigation/README.md#project-1-navigation.

<a name="dqn-nature-2015">[2]</a>: Mnih, Volodymyr, et al. "Human-level control
through deep reinforcement learning." Nature 518.7540 (2015): 529-533.

<a name="experience-replay-1993">[3]</a>: Lin, L.-J. Reinforcement learning for robots using neural networks. Technical
Report, DTIC Document (1993).

<a name="rainbow-aaai-2015">[4]</a>: Hessel, Matteo, et al. "Rainbow: Combining
improvements in deep reinforcement learning." Thirty-Second AAAI Conference on
Artificial Intelligence. 2018.
