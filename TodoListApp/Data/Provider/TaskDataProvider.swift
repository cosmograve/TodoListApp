//
//  TaskDataProvider.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

protocol TaskDataProviderProtocol {
    func getTaskList() -> [Task]
    func updateTaskList(_ task: Task) -> [Task]
    func toggleTaskStatus(_ task: Task) -> [Task]
    func deleteTask(_ task: Task) -> [Task]
    func getCurrentDateTasks(of date: Date) -> [Task]
}

class TaskDataProvider {
    private var taskList: [Task] = []
    
    init() {
        self.taskList = self.getTasksFromUserDefaults()
    }
    
    private func getTasksFromUserDefaults() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: "tasks") else { return [] }
        guard let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) else { return [] }
        return decodedTasks
    }
    
    private func saveTasksToUserDefaults() {
        guard let data = try? JSONEncoder().encode(taskList) else { return }
        UserDefaults.standard.set(data, forKey: "tasks")
    }
    
}

extension TaskDataProvider: TaskDataProviderProtocol {
    func getTaskList() -> [Task] {
        taskList
    }
    
    func updateTaskList(_ task: Task) -> [Task] {
        taskList.append(task)
        saveTasksToUserDefaults()
        return taskList
    }
    
    func toggleTaskStatus(_ task: Task) -> [Task] {
        if let index = taskList.firstIndex(of: task) {
            taskList[index].isCompleted.toggle()
            saveTasksToUserDefaults()
        }
        return taskList
    }
    
    func deleteTask(_ task: Task) -> [Task] {
        if let index = taskList.firstIndex(of: task) {
            taskList.remove(at: index)
            saveTasksToUserDefaults()
        }
        return taskList
    }
    
    func getCurrentDateTasks(of date: Date) -> [Task] {
        let filteredTasks = taskList.filter { task in
            let taskDateString = task.date.toString(format: "EEEE, dd MMMM yyyy")
            let currentDateString = date.toString(format: "EEEE, dd MMMM yyyy")
            return taskDateString == currentDateString
        }
        
        return filteredTasks.sorted { !$0.isCompleted && $1.isCompleted }
    }
}
