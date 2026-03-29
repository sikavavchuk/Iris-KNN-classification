This project implements the k-Nearest Neighbors (k-NN) algorithm from scratch in Swift to classify iris flowers based on their features.
The program reads training and test datasets, performs classification using Euclidean distance, evaluates accuracy, and allows interactive predictions for new samples.

How it works:
1. Load data from training and test .txt files.
2. Reading parameter k from users.
3. For each test sample computes the distance to all training samples, selects k nearest neighbors, perform majority voting.
4. Calculate classification accuracy.
5. Optional: takes single test sample from user and classify the prediction based on training sample.

What is a k-NN algorithm you can find here: https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm.

Technologies: SWIFT, Xcode

Constraints: No external Machine Learning libraries used, all algorithms implemented manually. 

Author: Viktoriia Savchuk



