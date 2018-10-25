//
//  ViewController.swift
//  todoapp
//
//  Created by Sam on 10/24/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var selected: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "TodoApp"
    }
    
    private var tasks = Task.getMockData()
    
    @IBAction func tappedNewTaskButton(_ sender: UIBarButtonItem) {
        addTask(name: "New Task")
    }
   
    
    private func addTask(name: String) {
        let newCellIndex = tasks.count
        tasks.append(Task(name: name))
        tableView.insertRows(at: [IndexPath(row: newCellIndex, section: 0)], with: .top)
    }
    
    //Tells view number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //Set cell properties
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
        selected = tasks[indexPath.row].name
        performSegue(withIdentifier: "detailTransition", sender: self)
    }


}

