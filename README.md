#The Travelling Salesman Problem

###Problem Statement
A salesman has to visit every city and eventually return to the city he started from, thereby making a complete round trip. Of all the possible ways he can make a round trip, we have to find the shortest one of them.

###Difficulty
Belonging to the class of NP-complete problems, it get exponentially difficult to explore all the possible paths to find the shortest path as the number of cities increases.

#Simulated Annealing

Motivated from the principles of thermodynamics, simulated annealing is a derivative-free optimization technique that gets a close to optimal solution. Here's how we use Simulated Annealing to solve the Travelling Salesman Problem: 

1. Set temperature very high. 
2. Choose a random ordering of cities. 
3. Compute the total distance of the path given by the random ordering.
4. Now pick any two random cities, and swap them in the ordering from the previous step.
5. Again compute the total distance of the new path we obtained after swapping.
6. The acceptance function gives a probability with which the new path should be considered based on the change in the total distance and the temperature.
7. Repeat steps 4. to 7. untill no further change in distance is observed.

