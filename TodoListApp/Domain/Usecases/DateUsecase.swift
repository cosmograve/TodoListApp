//
//  DateUsecase.swift
//  TodoListApp
//
//  Created by Алексей on 25.02.2025.
//

import Foundation

protocol DateUsecaseProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

final class DateUsecase {
    private let dateRepository: DateRepositoryProtocol
    
    init(dateRepository: DateRepositoryProtocol) {
        self.dateRepository = dateRepository
    }
}

extension DateUsecase: DateUsecaseProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        dateRepository.calculatePastAndFutureWeeks(with: date)
    }
}
