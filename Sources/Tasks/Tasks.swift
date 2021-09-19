
import Foundation

public class UploadTask: Task {
    
    public typealias TaskResultType = Bool
    
    public var id                : UUID
    public var state             : TaskState
    public var error             : Error?
    public var result            : Bool?
    
    public lazy var completionHandler : CompletionHandler = self.onTaskCompleted(with:)
    
    public init() {
        
        self.id    = UUID()
        self.state = .Pending
    }
    
    public func execute() {
        
        
    }
    
    public func onTaskCompleted(with result: TaskResult<TaskResultType>) {
        
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
        
        task.execute()
        taskGroup.execute()
    }
}
