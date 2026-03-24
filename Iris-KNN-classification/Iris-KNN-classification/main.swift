//
//  main.swift
//  Iris-KNN-classification
//
//  Created by Viktoriia Savchuk  on 24/03/2026.
//

import Foundation

print("Print your practise file name, be sure that this file is in a document directory! \n")
let practiseFile: String = readLine() ?? "iris_training.txt"

print("Print your test file name, be sure that this file is in a document directory! \n")
let testFile: String = readLine() ?? "iris_test.txt"

let brain = Brain()
let trainingData = brain.loadData(from: practiseFile)
let testData = brain.loadData(from: testFile)

print("Enter a number k: ", terminator: "")
let input = readLine()
let number = Int(input ?? "Type an Integer! ")

var predictions: [String] = []

for i in 0..<testData.count {
    let prediction = brain.classify(trainingSample: trainingData, newSample: testData[i], k: number ?? 3)
    predictions.append(prediction)
    print("Prediction \(i+1): \(prediction)")
}

let percentage: Double = brain.evaluate(predictions: predictions, actuals: testData)
print("-------------")
print("Percentage of correct answers is: \(percentage)%")
    


