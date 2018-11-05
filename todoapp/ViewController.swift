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
    private var tasks = [Task]()
    var viewMode = Int(0)
    var selectedCell = NSIndexPath()
    @IBOutlet weak var viewModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.rowHeight = 200
        
        self.title = "TodoApp"
        viewModeButton.setTitle("", for: .normal)
        
        //Listen for an updated task name or state
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "taskUpdated"), object: nil)
        
        //Listen for TodoApp moving to background
        NotificationCenter.default.addObserver(self, selector: #selector(saveList), name: UIApplication.willResignActiveNotification, object: nil)
        
        //Load saved data, if any exists
        do {
            self.tasks = try [Task].readSaveData()
        } catch let error as NSError {
            if error.domain == NSCocoaErrorDomain && error.code == NSFileNoSuchFileError {
                NSLog("No save data found.")
            } else {
                NSLog("Error reading from save data: \(error)")
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool { //Keeps status bar visible in landscape
        return false
    }
    
    // Filters not implemented
    @IBAction func viewModeButtonPressed(_ sender: Any) {
        viewMode = ((viewMode + 1) % 3)
        switch viewMode {
        case 0:
            viewModeButton.setTitle("", for: .normal)
        case 1:
            viewModeButton.setTitle("", for: .normal)
        case 2:
            viewModeButton.setTitle("", for: .normal)
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        for iden in tasks {
            if iden.isDone == true {
                return 200//Size you want to increase to
            }
        }
        return 50 // Default Size
    }
    
    
    //A user should be able to add a task...
    @IBAction func tappedNewTaskButton(_ sender: UIBarButtonItem) {
        addTask(name: "New Task")
    }
    
    //Reloads the table
    @objc func loadList(){
        self.tableView.reloadData()
    }
    
    //Saves the current list of tasks
    @objc func saveList(_ notification: Notification) {
        do {
            try tasks.writeSaveData()
        } catch let error {
            NSLog("Error saving data: \(error)")
        }
    }
    
    //Adds a new task to the list of tasks
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
    
    //Performs segue upon row tap
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = tasks[indexPath.row]
        performSegue(withIdentifier: "detailTransition", sender: self)
    }
    
    //Passes the Task tapped to the detail destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TaskDetailViewController {
            destination.selectedTask = selected
        }
    }
    
    //Lets us swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if indexPath.row < tasks.count
        {
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}

