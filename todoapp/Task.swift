//
//  Task.swift
//  todoapp
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.isDone, forKey: "isDone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        } else {
            return nil
        }
        
        if aDecoder.containsValue(forKey: "isDone") {
            self.isDone = aDecoder.decodeBool(forKey: "isDone")
        } else {
            return nil
        }
    }
    
    
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

extension Collection where Iterator.Element == Task {
    
    private static func buildSaveDataPath() -> URL? {
        let url = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return url?.appendingPathComponent("tasks.bin")
    }
    
    func writeSaveData() throws {
        if let url = Self.buildSaveDataPath(), let array = self as? NSArray {
            let data = NSKeyedArchiver.archivedData(withRootObject: array)
            try data.write(to: url)
        } else {
            throw NSError(domain: "com.spangeometry.todoapp", code: 10, userInfo: nil)
        }
    }
    
    static func readSaveData() throws -> [Task] {
        if let url = buildSaveDataPath(), let data = (try Data(contentsOf: url) as Data?) {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Task] {
                return array
            } else {
                throw NSError(domain: "com.spangeometry.todoapp", code: 11, userInfo: nil)
            }
        } else {
            throw NSError(domain: "com.spangeometry.todoapp", code: 12, userInfo: nil)
        }
    }
    
}
