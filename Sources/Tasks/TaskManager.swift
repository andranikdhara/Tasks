//
//  File.swift
//  
//
//  Created by Arnab Dhara on 20/09/21.
//

import Foundation

public class TaskManager {
    
    private var tasks: [UUID:TaskProtocol] = [:]
    
    public func add(task: TaskProtocol) {
        
        tasks[task.id] = task
    }
    
    public func getTask(with id: UUID) -> TaskProtocol? {
        
        return tasks[id]
    }
    
    public func removeTask(with id: UUID) -> TaskProtocol? {
        
        let removedItem = tasks.removeValue(forKey: id)
        return removedItem
    }
}
