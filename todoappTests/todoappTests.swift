//
//  todoappTests.swift
//  todoappTests
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import XCTest
@testable import todoapp

class todoappTests: XCTestCase {
    
    var testTask = Task(name: "Test task")
    
    func testTaskName() { //Tests initial task name
        XCTAssertEqual(testTask.name, "Test task")
    }
    
    func testTaskNameChange() { //Tests task name changes
        testTask.changeName(name: "Changed task name")
        XCTAssertEqual(testTask.name, "Changed task name")
    }
    
    func testTaskIsDoneFalse() { //Tests initial task state
        XCTAssertEqual(testTask.isDone, false)
    }
    
    func testTaskIsDoneToggle1() { //Tests task state toggles
        testTask.toggleDone()
        XCTAssertEqual(testTask.isDone, true)
    }
    
    func testTaskIsDoneToggle2() { //Tests task state toggles
        testTask.toggleDone()
        XCTAssertEqual(testTask.isDone, false)
    }
    
}
