//
//  TaskListItem.swift
//  TodoListApp
//
//  Created by Алексей on 24.02.2025.
//

import SwiftUI

struct TaskListItem: View {
    var task: Task
    @State private var showAlert: Bool = false
    var onTap: (Task) -> ()
    var onLongPress: (Task) -> ()
    
    var deleteAlert: Alert {
        Alert(title: Text("Hey!"),
              message: Text("Are you sure you want to delete this task?"),
              primaryButton: .destructive(Text("Delete"), action: deleteTask),
              secondaryButton: .cancel())
    }
    var body: some View {
        HStack {
            Circle()
                .fill(task.isCompleted ? .purple.opacity(0.3) : .purple)
                .frame(width: 25)
            
                Text(task.title)
                    .font(.system(size: 20, weight: .medium))
                    .padding()
                    .background(task.isCompleted ? .purple.opacity(0.3) : .purple)
                    .clipShape(.rect(cornerRadius: 10))
            Spacer()
            
        }
        .onTapGesture {
            withAnimation {
                onTap(task)
            }
        }
        .onLongPressGesture {
            showAlert.toggle()
        }
        .alert(isPresented: $showAlert) {
            deleteAlert
        }
    }
    private func deleteTask() {
        withAnimation {
            onLongPress(task)
        }
    }
}

#Preview {
    MainView(viewModel: MainViewViewModel(dateUsecase: DateUsecase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUsecase: TaskUsecase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider()))))
}
