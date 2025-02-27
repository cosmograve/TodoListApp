//
//  DateDataProvider.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

protocol DateDataProviderProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateDataProvider {
    private func week(for date: Date, with index: Int) -> WeekModel {
        var result: [Date] = .init()
        guard let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
            return .init(index: index, dates: [], referenceDate: date)
        }
        (0...6).forEach { day in
            if let weekDay = Calendar.current.date(byAdding: .day, value: day, to: startOfWeek) {
                result.append(weekDay)
            }
        }
        return WeekModel(index: index, dates: result, referenceDate: date)
    }
}

extension DateDataProvider: DateDataProviderProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        guard let previousWeek = Calendar.current.date(byAdding: .day, value: -7, to: date),
              let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: date) else {
            return []
        }
        return [
            week(for: previousWeek, with: -1),
            week(for: date, with: 0),
            week(for: nextWeek, with: 1)
        ]
    }
}
