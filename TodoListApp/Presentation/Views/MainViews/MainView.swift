//
//  ContentView.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

struct MainView: View {
    @State private var showNewTaskView: Bool = false
    @EnvironmentObject var weekManager: DateManager
    @EnvironmentObject var taskListManager: TaskListManager
    var body: some View {
        ZStack {
            VStack {
                DateHeaderView()
                ScrollView(.vertical) {
                    VStack {
                        TaskListView(date: $weekManager.selectedDate, tasks: $taskListManager.tasks)
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
            NewTaskView()
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    MainView()
        .environmentObject(DateManager())
        .environmentObject(TaskListManager())
}
