//
//  TaskListItem.swift
//  TodoListApp
//
//  Created by Алексей on 24.02.2025.
//

import SwiftUI

struct TaskListItem: View {
    @EnvironmentObject var taskListManager: TaskListManager
    @State private var showAlert: Bool = false
    var task: Task
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
                taskListManager.toggleTaskCompletion(task: task)
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
            taskListManager.deleteTask(task: task)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DateManager())
        .environmentObject(TaskListManager())
}
