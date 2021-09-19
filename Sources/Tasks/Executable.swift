//
//  File.swift
//  
//
//  Created by Arnab Dhara on 20/09/21.
//

import Foundation

public protocol Executable {
    
    associatedtype ExecutionResult
    
    typealias CompletionHandler = (_ result: TaskResult<ExecutionResult>) -> Void
    
    func execute(completionHandler: @escaping CompletionHandler)
}
