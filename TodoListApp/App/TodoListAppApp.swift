//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    @StateObject private var dateManager: DateManager = DateManager()
    @StateObject private var taskListManager: TaskListManager = TaskListManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(dateManager)
                .environmentObject(taskListManager)
        }
    }
}
