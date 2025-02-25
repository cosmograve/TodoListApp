//
//  DateRepository.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

protocol DateRepositoryProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateRepository {
    private let dateDataProvider: DateDataProviderProtocol
    
    init(dateDataProvider: DateDataProviderProtocol) {
        self.dateDataProvider = dateDataProvider
    }
}

extension DateRepository: DateRepositoryProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        return dateDataProvider.calculatePastAndFutureWeeks(with: date)
    }
    
    
}
