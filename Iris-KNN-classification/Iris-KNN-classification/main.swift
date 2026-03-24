//
//  main.swift
//  Iris-KNN-classification
//
//  Created by Viktoriia Savchuk  on 24/03/2026.
//

import Foundation

print("Print your practise file name, be sure that this file is in a document directory! \n")
var practiseFile: String = readLine() ?? "iris_training.txt"

print("-----------------------")
print("Program is trained using \(practiseFile) and \(practiseFile.count) samples")
print("-----------------------")

print("Print your test file name, be sure that this file is in a document directory! \n")
let testFile: String = readLine() ?? "iris_test.txt"

print("-----------------------")
print("Preparing the data...")
print("-----------------------")

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
    print("Prediction \(i+1): \(prediction), correct answer: \(testData[i])")
}

let correctPredictions: Int = brain.evaluate(predictions: predictions, actuals: testData)
print("-------------")
print("Answers \(correctPredictions)/\(testData.count)")

let percentage: Double = Double(correctPredictions) / Double(testData.count) * 100
print("Percentage of correct answers is: \(percentage)%")

var flag: Bool = true

while flag {
    
    print("-----------------------")
    print("\nDo you want to try another test? \n")
    print("-----------------------")
    print(">> Type 'exit' to exit the program")
    
    let choice: String = readLine() ?? "Type a valid input!"
    
    if choice == "exit" {
        flag = false
        break
    }
    print("-----------------------")
    print(">> Do you want to change training data? (Yes/No) ")
    print("-----------------------")
    
    if readLine()!.lowercased() == "yes" {
        practiseFile = readLine() ?? "Type a valid input!"
    } else {
        brain.interactiveMode(trainingSample: trainingData, k: number ?? 3)
    }
    
}
    


