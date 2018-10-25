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
    
    var selectedTask: Task?
    @IBOutlet weak var newTaskNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedTask?.name
    }
    
}
