//
//  File.swift
//  
//
//  Created by Arnab Dhara on 20/09/21.
//

import Foundation

public enum TaskResult<T> {
    
    case Success(result: T)
    case Failure(error: Error)
}


public protocol Task: TaskProtocol {
    
    associatedtype TaskResultType
    
    typealias CompletionHandler = (_ result: TaskResult<TaskResultType>) -> Void
    
    var completionHandler: CompletionHandler { get }
    
}
