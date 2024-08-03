import numpy as np
import matplotlib.pyplot as plt
import networkx as nx

# Initial parameter setting
N = 10000  # Total players
G_val = 5  # Number of players per group
x0 = 0.05  # Initial cooperator ratio
p = 0.4   # The probability of a synergy group
delta = 0.6  # Nonlinear payoff coefficient
r = 4   # Payoff coefficient in public goods games 
s = 0.02   # Sensitivity parameters of Fermi function

# Constructing regular graph
graph = nx.random_regular_graph(G_val - 1, N)

# Gets the adjacency matrix of the regular graph
adj_matrix = nx.adjacency_matrix(graph).toarray()

# Initial strategy assignment, 1 for cooperation, 0 for defection
strategies = np.random.choice([1, 0], size=N, p=[x0, 1-x0])

def calculate_payoff(n_C, synergy):
    """Calculate the payoff for each player based on the number of cooperators and group type (synergy or discounting)"""
    if synergy:
        omega = 1 + delta
    else:
        omega = 1 - delta
    
    return (r/G_val) * (1 - (omega) ** n_C) / (1 - omega)

T = 100000000  # Time steps
cooperator_ratios = []  # Stores the proportion of cooperators per time step

for t in range(T):
    i = np.random.choice(N)  # Choose a player i at random
    neighbors = np.where(adj_matrix[i])[0]  # Get player i's neighbors
    n_C_self = np.sum(strategies[neighbors])  # Count the number of cooperators in player i's neighborhood
    synergy = np.random.rand() < p  # Decide if it is a synergy group
    payoffs_1 = calculate_payoff(n_C_self + strategies[i], synergy)
    if strategies[i] == 1:
        payoffs_1 -= 1  # If the current player is a cooperator, subtract the cost of their contribution

    for neighbor in neighbors:
        neighbors_1 = np.where(adj_matrix[neighbor])[0]  # Get neighbors of “neighbor”.
        n_C = np.sum(strategies[neighbors_1])  # Calculate the number of cooperators in the neighborhood of the neighbor “neighbor”.
        synergy = np.random.rand() < p  # Decide if it is a synergy group
        payoffs_1 += calculate_payoff(n_C + strategies[neighbor], synergy)
        if strategies[i] == 1:
            payoffs_1 -= 1  # If the current player is a cooperator, subtract the cost of their contribution
    
    j = np.random.choice(neighbors)  # Randomly select a neighboring player for comparison

    if strategies[i] != strategies[j]:  # Learn if the strategies are different
        neighbors_j = np.where(adj_matrix[j])[0]  # Get player j's neighbors
        n_C_self_j = np.sum(strategies[neighbors_j])  # Calculate the number of collaborators in neighbor j
        synergy = np.random.rand() < p
        payoffs_2 = calculate_payoff(n_C_self_j + strategies[j], synergy)
        if strategies[j] == 1:
            payoffs_2 -= 1

        for neighbor_j in neighbors_j:
            neighbors_2 = np.where(adj_matrix[neighbor_j])[0]
            n_C_j = np.sum(strategies[neighbors_2])
            synergy = np.random.rand() < p 
            payoffs_2 += calculate_payoff(n_C_j + strategies[neighbor_j], synergy)
            if strategies[j] == 1:
                payoffs_2 -= 1 
        
        pi_diff = payoffs_2 - payoffs_1
        probability = 1 / (1 + np.exp(-s * pi_diff))  # Calculate the probability according to Fermi's rules
        if np.random.rand() < probability:
            strategies[i] = strategies[j]  # i adopts j's strategy
    
    # Calculate and store the cooperator ratio
    cooperator_ratio = np.mean(strategies)
    cooperator_ratios.append(cooperator_ratio)

    # Check if all players are cooperators or defectors
    if cooperator_ratio == 0 or cooperator_ratio == 1:
        break  # If full cooperation or defection is achieved, stop the simulation


# Plot the evolution of the partner ratio
plt.figure(figsize=(8, 6))
plt.plot(cooperator_ratios, label='Cooperator ratio')
plt.xscale('log')
plt.xlabel('Time')
plt.ylim(0,1)
plt.ylabel('Cooperator ratio')
plt.title('Evolution of cooperator ratio over time')
plt.legend()
plt.show()