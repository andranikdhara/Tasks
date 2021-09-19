//
//  File.swift
//  
//
//  Created by Arnab Dhara on 20/09/21.
//

import Foundation

public enum TaskState {
    
    case Pending
    case Started
    case Suspended
    case Completed
    case InProgress
}

public protocol TaskProtocol {
    
    var id    : UUID      { get }
    var state : TaskState { get }
}
