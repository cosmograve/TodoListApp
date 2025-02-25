//
//  TaskListView.swift
//  TodoListApp
//
//  Created by Алексей on 24.02.2025.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: MainViewViewModel
    var currentDateTasks: [Task] = []
    init(viewModel: MainViewViewModel) {
        self.viewModel = viewModel
        currentDateTasks = viewModel.getCurrentTasks()
    }
    var body: some View {
        VStack {
            ForEach(currentDateTasks) { task in
                TaskListItem(task: task) { Task in
                    viewModel.toggleTaskCompletion(for: Task)
                } onLongPress: { Task in
                    viewModel.deleteTask(Task)
                }
            }
        }
        .padding(.top, 15)
    }
}

#Preview {
    MainView(viewModel: MainViewViewModel(dateUsecase: DateUsecase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUsecase: TaskUsecase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider()))))
}
