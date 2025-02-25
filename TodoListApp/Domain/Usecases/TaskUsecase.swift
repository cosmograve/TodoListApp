//
//  TaskUsecase.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

protocol TaskUsecaseProtocol {
    func getTaskList() -> [Task]
    func updateTaskList(_ task: Task) -> [Task]
    func toggleTaskStatus(_ task: Task) -> [Task]
    func deleteTask(_ task: Task) -> [Task]
    func getCurrentDateTasks(of date: Date) -> [Task]
}

final class TaskUsecase {
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
}

extension TaskUsecase: TaskUsecaseProtocol {
    func getTaskList() -> [Task] {
        taskRepository.getTaskList()
    }
    
    func updateTaskList(_ task: Task) -> [Task] {
        taskRepository.updateTaskList(task)
    }
    
    func toggleTaskStatus(_ task: Task) -> [Task] {
        taskRepository.toggleTaskStatus(task)
    }
    
    func deleteTask(_ task: Task) -> [Task] {
        taskRepository.deleteTask(task)
    }
    
    func getCurrentDateTasks(of date: Date) -> [Task] {
        taskRepository.getCurrentDateTasks(of: date)
    }
}
