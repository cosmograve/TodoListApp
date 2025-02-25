//
//  TaskRepository.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

protocol TaskRepositoryProtocol {
    func getTaskList() -> [Task]
    func updateTaskList(_ task: Task) -> [Task]
    func toggleTaskStatus(_ task: Task) -> [Task]
    func deleteTask(_ task: Task) -> [Task]
    func getCurrentDateTasks(of date: Date) -> [Task]
}

class TaskRepository {
    private let taskDataProvider: TaskDataProviderProtocol
    
    init(taskDataProvider: TaskDataProvider) {
        self.taskDataProvider = taskDataProvider
    }
}

extension TaskRepository: TaskRepositoryProtocol {
    func getTaskList() -> [Task] {
        taskDataProvider.getTaskList()
    }
    
    func updateTaskList(_ task: Task) -> [Task] {
        taskDataProvider.updateTaskList(task)
    }
    
    func toggleTaskStatus(_ task: Task) -> [Task] {
        taskDataProvider.toggleTaskStatus(task)
    }
    
    func deleteTask(_ task: Task) -> [Task] {
        taskDataProvider.deleteTask(task)
    }
    
    func getCurrentDateTasks(of date: Date) -> [Task] {
        taskDataProvider.getCurrentDateTasks(of: date)
    }
}
