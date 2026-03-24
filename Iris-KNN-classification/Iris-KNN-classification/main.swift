//
//  main.swift
//  Iris-KNN-classification
//
//  Created by Viktoriia Savchuk  on 24/03/2026.
//

import Foundation

let brain = Brain()
let trainingData = brain.loadData(from: "iris_training.txt")
let testData = brain.loadData(from: "iris_test.txt")

print("Number of training samples: \(trainingData.count)")
print("Number of test samples: \(testData.count)")

for i in 0..<min(5, trainingData.count) {
    let sample = trainingData[i]
    print("Features: \(sample.features), Label: \(sample.label)")
}



