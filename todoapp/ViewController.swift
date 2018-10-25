//
//  ViewController.swift
//  todoapp
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var selected: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "TodoApp"
    }
    
    private var tasks = Task.getMockData()
    
    //A user should be able to add a task...
    @IBAction func tappedNewTaskButton(_ sender: UIBarButtonItem) {
        addTask(name: "New Task")
    }
   
    
    private func addTask(name: String) {
        tasks.append(Task(name: name))
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //Set cell name and add checkmark for completed tasks
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_task", for: indexPath)
        
        if indexPath.row < tasks.count {
            let task = tasks[indexPath.row]
            cell.textLabel?.text = task.name
            
            let accessory: UITableViewCell.AccessoryType = task.isDone ? .checkmark : .none
            cell.accessoryType = accessory
        }
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = tasks[indexPath.row]

        performSegue(withIdentifier: "detailTransition", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TaskDetailViewController {
            destination.selectedTask = selected
        }
    }


}

