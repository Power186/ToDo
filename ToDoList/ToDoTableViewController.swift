//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Scott on 1/7/21.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    var todos = [ToDo]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        loadToDos()
    }
    
    func loadToDos() {
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
    }

    // MARK: - Table View data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        let todo = todos[indexPath.row]
        cell.update(with: todo)
        cell.delegate = self
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? ToDoDetailTableViewController,
              let todo = sourceViewController.todo else { return }
        
        if let indexOfExistingToDo = todos.firstIndex(of: todo) {
            todos[indexOfExistingToDo] = todo
            tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        ToDo.saveToDos(todos)
    }
    
    // MARK: - Helper Functions
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete.toggle()
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    // MARK: - Navigation

    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return nil }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = ToDoDetailTableViewController(coder: coder)
        detailViewController?.todo = todos[indexPath.row]
        return detailViewController
    }
    

}
