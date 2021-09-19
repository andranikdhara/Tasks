//
//  File.swift
//  
//
//  Created by Arnab Dhara on 20/09/21.
//

import Foundation

public class TaskGroup<T : Task> : Task {
    
    public typealias ExecutionResult = TaskGroupResult
    
    public var id: UUID
    public var state: TaskState
    
    private var tasks : [T]
    private let queue : DispatchQueue
    private let group : DispatchGroup
    
    private var successfulTasks:   [SuccessfulTaskResult]   = []
    private var unsuccessfulTasks: [UnsuccessfulTaskResult] = []
    
    public struct UnsuccessfulTaskResult {
        
        let task  : T
        let error : Error
    }
    
    public struct SuccessfulTaskResult {
        
        let task   : T
        let result : T.ExecutionResult
    }
    
    public struct TaskGroupResult {
        
        let successfulTasks   : [SuccessfulTaskResult]
        let unsuccessfulTasks : [UnsuccessfulTaskResult]
    }
    
    public init(of tasks: [T]) {
        
        self.id    = UUID()
        self.tasks = []
        self.state = .Pending
        self.group = DispatchGroup()
        self.queue = DispatchQueue.global(qos: .background)
    }
    
    public func execute(completionHandler: @escaping CompletionHandler) {
    
        for task in tasks {
            
            group.enter()
            task.execute { [self] (result) in

                switch result {
                
                    case .Success(let result):
                        let successfulResult = SuccessfulTaskResult(task: task, result: result)
                        successfulTasks.append(successfulResult)
                        break
                        
                    case .Failure(let error):
                        let unsuccessfulResult = UnsuccessfulTaskResult(task: task, error: error)
                        unsuccessfulTasks.append(unsuccessfulResult)
                        break
                }
                group.leave()
            }
        }
        group.notify(queue: queue) { [self] in

            let taskGroupResult = TaskGroupResult(successfulTasks: successfulTasks,
                                                  unsuccessfulTasks: unsuccessfulTasks)
            
            let result = TaskResult<TaskGroupResult>.Success(result: taskGroupResult)
            completionHandler(result)
        }
    }
}
