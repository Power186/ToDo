//
//  ToDo.swift
//  ToDoList
//
//  Created by Scott on 1/7/21.
//

import UIKit

struct ToDo: Equatable {
    let id = UUID()
    var title: String
    var image: UIImage?
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let dueDateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo 1", image: nil, isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo 2", image: nil, isComplete: true, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo 3", image: nil, isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
}
