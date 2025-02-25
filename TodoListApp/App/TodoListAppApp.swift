//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    @StateObject private var viewModel: MainViewViewModel = MainViewViewModel(dateUsecase: DateUsecase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUsecase: TaskUsecase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())))
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
