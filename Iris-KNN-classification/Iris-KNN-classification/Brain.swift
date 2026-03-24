//
//  Brain.swift
//  Iris-KNN-classification
//
//  Created by Viktoriia Savchuk  on 24/03/2026.
//

import Foundation

struct Brain {
    
    func loadData(from fileName: String) -> [Sample] {
        var samples: [Sample] = []

        //get the file path in Documents folder
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)

            //debug lines
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("File does NOT exist: \(fileURL.path)")
                return samples
            }

            print("File exists: \(fileURL.path)")

            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                
                //normalize line endings, replace all \r\n and \r with \n so every line is separated consistently
                let normalizedText = text
                    .replacingOccurrences(of: "\r\n", with: "\n")
                    .replacingOccurrences(of: "\r", with: "\n")

                let lines = normalizedText.split(separator: "\n")

                for line in lines {
                    let parts = line.split { $0 == " " || $0 == "\t" }

                    guard parts.count >= 2 else { continue }

                    var features: [Double] = []

                    for i in 0..<(parts.count - 1) {
                        let value = parts[i].replacingOccurrences(of: ",", with: ".")
                        if let num = Double(value) {
                            features.append(num)
                        } else {
                            print("Warning: could not parse number '\(parts[i])'")
                        }
                    }

                    let label = String(parts.last!)
                    let sample = Sample(features: features, label: label)
                    samples.append(sample)
                }

            } catch {
                print("Error reading file: \(error)")
            }
        }

        return samples
    }
    
    //Calculates how similar two flowers are
    func euclidianDistance(_ sample1: Sample, _ sample2: Sample) -> Double {
        
        let features1 = sample1.features
        let features2 = sample2.features
        
        var sum: Double = 0
        
        if features1.count != features2.count {
            print("There is something wrong with your datasets.")
            return Double.infinity
        }
        
        for i in 0..<features1.count {
            let difference: Double = features1[i] - features2[i]
            sum += difference * difference
        }
        
        return sqrt(sum)
    }
    
    //Predicts the class of a new flower
    func classify(trainingSample: [Sample], newSample: Sample, k: Int) -> String {
        
        var distances: [SampleWithDistance] = []
        var closestDistances: [SampleWithDistance] = []
        
        for i in 0..<trainingSample.count {
            let num = euclidianDistance(trainingSample[i], newSample)
            let newSampleWithDistance: SampleWithDistance = SampleWithDistance(distance: num, label: trainingSample[i].label)
            distances.append(newSampleWithDistance)
        }
        
        closestDistances = distances.sorted { $0.distance < $1.distance }
        
        let kClosestDistances = closestDistances.prefix(k)
        
        var voteCount: [String: Int] = [:]
        
        for neighbor in kClosestDistances {
            voteCount[neighbor.label, default: 0] += 1
        }
        
        let sortedVotes = voteCount.sorted { $0.value > $1.value }
        
        let predictedLabel: String = sortedVotes.first!.key
        
        return predictedLabel
        
    }
    
    //Checks how good your model is
    func evaluate(predictions: [String], actuals: [Sample]) -> Int {
        
        var correctPredictions: Int = 0
        
        for i in 0..<actuals.count {
            if predictions[i] == actuals[i].label {
                correctPredictions += 1
            }
        }
        
        return correctPredictions
        
    }
    
    //Lets the user fully interact with my program
    func interactiveMode(trainingSample: [Sample], k: Int) {
        
        let amountOfFeatures: Int = trainingSample[1].features.count
        
        var userFeatures: [Double] = []
        
        for i in 0..<amountOfFeatures {
            print("Print feature of your sample at index \(i+1): ")
            let input = readLine()
            let feature = Double(input ?? "Type a Double!")!
            
            userFeatures.append(feature)
        }
        
        let userSample: Sample = Sample(features: userFeatures, label: "Unknown")
        
        let prediction: String = classify(trainingSample: trainingSample, newSample: userSample, k: k)
        
        print("The predicted label for your sample is: \(prediction)")
        
    }
    
}
