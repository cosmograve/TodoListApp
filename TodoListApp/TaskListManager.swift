//
//  TaskListManager.swift
//  TodoListApp
//
//  Created by Алексей on 23.02.2025.
//

import Foundation

class TaskListManager: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            refreshTasksList()
        }
    }
    
    init() {
        self.tasks = getTasksList()
    }
    
    private func refreshTasksList() {
        guard let data = try? JSONEncoder().encode(tasks) else { return }
        UserDefaults.standard.set(data, forKey: "tasks")
    }
    
    func getTasksList() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: "tasks") else { return [] }
        guard let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) else { return [] }
        tasks = decodedTasks
        return tasks
    }
    
    func updateTasksList(task: Task) {
        tasks.append(task)
    }
    
    func deleteTask(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        }
    }
    
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].isCompleted.toggle()
        }
    }
}
