//
//  TaskDetailViewController.swift
//  todoapp
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var originalTaskName: UILabel!
    @IBOutlet weak var newTaskNameField: UITextField!
    @IBOutlet weak var editNameButton: UIButton!
    @IBOutlet weak var editStatusButton: UISwitch!
    
    var selectedTask: Task? //The task the user tapped on
    
    //Prepares input; prevents empty input
    var inputText: String {
        if let text = newTaskNameField.text, !text.isEmpty {
            return text
        } else {
            return selectedTask?.name ?? ""
        }
    }
    
    //Toggles task completion state
    @IBAction func statusPressed(_ sender: UISwitch) {
        selectedTask?.toggleDone()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "taskUpdated"), object: nil)
        editStatusButton.isOn = selectedTask?.isDone ?? false
    }
    
    //Confirms task name edit
    @IBAction func editButtonPressed(_ sender: UIButton) {
        selectedTask?.changeName(name: inputText)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "taskUpdated"), object: nil)
        self.originalTaskName.text = selectedTask?.name
    }
    
    //Handles task name display and switch status
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originalTaskName.text = selectedTask?.name
        editStatusButton.isOn = selectedTask?.isDone ?? false
    }
    
}
