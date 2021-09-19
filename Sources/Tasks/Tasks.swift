
import Foundation

public class UploadTask: Task {
    
    public typealias ExecutionResult = Bool
    
    public var id                : UUID
    public var state             : TaskState
    
    public init() {
        
        self.id    = UUID()
        self.state = .Pending
    }
    
    public func execute(completionHandler: CompletionHandler) {
        
        
    }
    
    public func onTaskCompleted(with result: TaskResult<ExecutionResult>) {
        
        switch result {
        
            case .Success(let result):
                print(result)
                break
                
            case .Failure(let error):
                print(error)
                break
        }
    }
}

public class Main {
    
    func main() {
        
        let tasks: [UploadTask] = []
        
        let task        = UploadTask()
        let taskGroup   = TaskGroup(of: tasks)
        let taskManager = TaskManager()
        
        taskManager.add(task: task)
        taskManager.add(task: taskGroup)
        
        task.execute { result in
            
            switch result {
            
                case .Success(let result):
                    
                    print(result)
                    break
                    
                case .Failure(let error):
                    
                    print(error)
                    break
                
            }
        }
        
        taskGroup.execute { result in
            
            switch result {
            
                case .Success(let result):
                    
                    _ = result.successfulTasks
                    _ = result.unsuccessfulTasks
                    break
                    
                case .Failure(let error):
                    
                    print(error)
                    break
                
            }
        }
    }
}
