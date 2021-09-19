//
//  File.swift
//  
//
//  Created by Arnab Dhara on 20/09/21.
//

import Foundation

public class TaskGroup<T : Task> : Task {
    
    public typealias TaskResultType = Bool
    
    public var id: UUID
    public var state: TaskState
    
    public lazy var completionHandler: CompletionHandler = self.onTaskCompleted
    
    private var tasks: [T]
    
    public init(of tasks: [T]) {
        
        self.id    = UUID()
        self.state = .Pending
        self.tasks = []
    }
    
    public func execute() {
        
        for task in tasks { task.execute() }
    }
    
    public func onTaskCompleted(with result: TaskResult<TaskResultType>) {
        
        
    }
}
