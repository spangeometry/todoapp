//
//  TaskDetailViewController.swift
//  todoapp
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var selectedTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = selectedTask?.name
    }
    
}
