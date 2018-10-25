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
    
    var selectedTask: Task?
    
    var inputText: String {
        if let text = newTaskNameField.text {
            return text
        } else {
            return selectedTask?.name ?? ""
        }
    }
    @IBAction func statusPressed(_ sender: UISwitch) {
        selectedTask?.toggleDone()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        editStatusButton.isOn = selectedTask?.isDone ?? false
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        selectedTask?.changeName(name: inputText)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.originalTaskName.text = selectedTask?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originalTaskName.text = selectedTask?.name
        editStatusButton.isOn = selectedTask?.isDone ?? false
    }
    
}
