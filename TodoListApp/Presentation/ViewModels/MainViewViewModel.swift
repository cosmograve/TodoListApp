//
//  MainViewViewModel.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

struct MainViewCosnstants {
    
}

enum SliderTimeDirection {
    case future, past, unknown
}

protocol MainViewViewModelInputProtocol {
    func selectTheDay(with date: Date)
    func onDateScrolled(to direction: SliderTimeDirection)
    
    func updateTaskList(with task: Task)
    func toggleTaskCompletion(for task: Task)
    func deleteTask(_ task: Task)
}

protocol MainViewViewModelOutputProtocol {
    func getSelectedDate() -> Date
    func getCurrentTasks() -> [Task]
}

protocol MainViewViewModelProtocol: ObservableObject, MainViewViewModelInputProtocol, MainViewViewModelOutputProtocol {
    
}

final class MainViewViewModel: MainViewViewModelProtocol {
    private let dateUsecase: DateUsecaseProtocol
    private let taskUsecase: TaskUsecaseProtocol
    
    @Published var tasks: [Task] = []
    @Published var weeks: [WeekModel] = []
    @Published var selectedDate: Date {
        didSet {
            calculatePastAndFutureWeeks(with: selectedDate)
        }
    }
    
    init(dateUsecase: DateUsecaseProtocol, taskUsecase: TaskUsecaseProtocol, date: Date = Date()) {
        self.dateUsecase = dateUsecase
        self.taskUsecase = taskUsecase
        self.selectedDate = Calendar.current.startOfDay(for: date)
        calculatePastAndFutureWeeks(with: selectedDate)
        self.tasks = taskUsecase.getTaskList()
    }
    
    private func calculatePastAndFutureWeeks(with date: Date) {
        weeks = dateUsecase.calculatePastAndFutureWeeks(with: date)
    }
}

// MARK: - Input
extension MainViewViewModel {
    func selectTheDay(with date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
    }
    
    func onDateScrolled(to direction: SliderTimeDirection) {
        switch direction {
        case .future:
            selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate) ?? selectedDate
        case .past:
            selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate) ?? selectedDate
        case .unknown:
            calculatePastAndFutureWeeks(with: selectedDate)
        }
    }
    
    func updateTaskList(with task: Task) {
        tasks = taskUsecase.updateTaskList(task)
    }
    
    func toggleTaskCompletion(for task: Task) {
        tasks = taskUsecase.toggleTaskStatus(task)
    }
    
    func deleteTask(_ task: Task) {
        tasks = taskUsecase.deleteTask(task)
    }
}
// MARK: - Output
extension MainViewViewModel {
    func getSelectedDate() -> Date {
        selectedDate
    }
    
    func getCurrentTasks() -> [Task] {
        taskUsecase.getCurrentDateTasks(of: selectedDate)
    }
}
