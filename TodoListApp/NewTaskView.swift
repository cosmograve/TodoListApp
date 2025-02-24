//
//  NewTaskView.swift
//  TodoListApp
//
//  Created by Алексей on 24.02.2025.
//

import SwiftUI

struct NewTaskView: View {
    @EnvironmentObject private var taskListManager: TaskListManager
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = Date()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Add new task")
                .font(.title2)
                .fontDesign(.rounded)
                .padding(30)
                .frame(maxWidth: .infinity)
                .background {
                    Rectangle()
                        .fill(.purple.opacity(0.3))
                        .clipShape(.rect(bottomLeadingRadius: 20, bottomTrailingRadius: 20))
                }
            Spacer()
            VStack(spacing: 24) {
                TextField("Task title", text: $taskTitle)
                    .padding(.top)
                
                HStack {
                    Text("Time")
                        .font(.title3)
                    Spacer()
                    DatePicker("", selection: $taskDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
            }
            .padding(24)
            Spacer()
            Button {
                taskListManager.updateTasksList(task: Task(title: taskTitle, date: taskDate))
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.purple)
                    Text("Add task")
                        .foregroundColor(.white)
                }
                .frame(height: 54)
                .padding(.horizontal, 24)
            }

        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DateManager())
        .environmentObject(TaskListManager())
}
