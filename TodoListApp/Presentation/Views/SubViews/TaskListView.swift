//
//  TaskListView.swift
//  TodoListApp
//
//  Created by Алексей on 24.02.2025.
//

import SwiftUI

struct TaskListView: View {
    @Binding var date: Date
    @Binding var tasks: [Task]
    private var currentDateTasks: [Task] {
        let filteredTasks = tasks.filter { task in
            let taskDateString = task.date.toString(format: "EEEE, dd MMMM yyyy")
            let currentDateString = date.toString(format: "EEEE, dd MMMM yyyy")
            return taskDateString == currentDateString
        }
        
        return filteredTasks.sorted { !$0.isCompleted && $1.isCompleted }
    }
    
    init(date: Binding<Date>, tasks: Binding<[Task]>) {
        self._date = date
        self._tasks = tasks
    }
    var body: some View {
        VStack {
            ForEach(currentDateTasks) { task in
                TaskListItem(task: task)
            }
        }
        .padding(.top, 15)
    }
}

#Preview {
    MainView()
        .environmentObject(DateManager())
        .environmentObject(TaskListManager())
}
