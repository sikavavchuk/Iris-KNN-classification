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

print("Enter a number k: ", terminator: "")
let input = readLine()
let number = Int(input ?? "Type an Integer! ")

let answer = brain.classify(trainingSample: trainingData, newSample: testData[2], k: number ?? 3)

print(answer)

for i in 0..<testData.count {
    let prediction = brain.classify(trainingSample: trainingData, newSample: testData[i], k: number ?? 3)
    print("Prediction \(i+1): \(prediction)")
}
    


