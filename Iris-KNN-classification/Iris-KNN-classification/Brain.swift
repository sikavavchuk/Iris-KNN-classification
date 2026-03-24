//
//  Brain.swift
//  Iris-KNN-classification
//
//  Created by Viktoriia Savchuk  on 24/03/2026.
//

import Foundation

struct Brain {
    
    func loadData(){
        
        // Source - https://stackoverflow.com/a/24098149
        // Posted by Adam, modified by community. See post 'Timeline' for change history
        // Retrieved 2026-03-24, License - CC BY-SA 4.0

        let trainingFile = "iris_training.txt" //this is the file. we will read from it

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(trainingFile)
            
            print(fileURL.path)

            if FileManager.default.fileExists(atPath: fileURL.path) {
                print("File exists")
            } else {
                print("File does NOT exist")
            }

            //reading
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
            }
            catch {/* error handling here */}
        }
    }
    
    func euclidianDistance() {} //Calculates how similar two flowers are
        
    func classify() {} //Predicts the class of a new flower
        
    func evaluate() {} //Checks how good your model is
        
    func interactiveMode() {} //Lets the user fully interact with my program
        
}
