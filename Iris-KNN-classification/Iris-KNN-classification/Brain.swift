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
        
        //The guard statement in Swift provides a concise way to enforce early exits from a block of code when certain conditions aren't met. It's commonly used to validate inputs, unwrap optionals, and check preconditions—helping developers write clearer, flatter, and more readable code.
        
        guard features1.count != features2.count else {
            print("There is something wrong with your datasets.")
            return Double.infinity
        }
        
        for i in 0..<features1.count {
            let difference: Double = features1[i] - features2[i]
            sum += difference * difference
        }
        
        return sqrt(sum)
    }
        
    func classify(trainingSample: [Sample], newSample: Sample) {
        
    } //Predicts the class of a new flower
        
    func evaluate() {} //Checks how good your model is
        
    func interactiveMode() {} //Lets the user fully interact with my program
        
}
