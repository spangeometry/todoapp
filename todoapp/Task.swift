//
//  Task.swift
//  todoapp
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import Foundation

class Task {
    
    var name: String
    var isDone: Bool
    
    public init(name: String) {
        self.name = name
        self.isDone = false
    }
    
    public func changeName(name: String) {
        self.name = name
    }
    
    public func toggleDone() {
        isDone = !isDone
    }
    
}

extension Task {
    
    public class func getMockData() -> [Task] {
        return [
            Task(name: "520 Homework"),
            Task(name: "520 Midterm"),
            Task(name: "690 Homework")
        ]
    }
    
}
