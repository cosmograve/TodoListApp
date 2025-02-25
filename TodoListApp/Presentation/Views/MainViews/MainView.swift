//
//  ContentView.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

struct MainView: View {
    @State private var showNewTaskView: Bool = false
    @ObservedObject var viewModel: MainViewViewModel
    var body: some View {
        ZStack {
            VStack {
                DateHeaderView(viewModel: viewModel)
                ScrollView(.vertical) {
                    VStack {
                        TaskListView(viewModel: viewModel)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            .overlay(alignment: .bottomTrailing) {
                Button {
                    showNewTaskView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.purple)
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showNewTaskView) {
            NewTaskView() { task in
                viewModel.updateTaskList(with: task)
            }
            .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    MainView(viewModel: MainViewViewModel(dateUsecase: DateUsecase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUsecase: TaskUsecase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider()))))
}
