//
//  AppDependencyContainer.swift
//  TodoListApp
//
//  Created by Алексей on 27.02.2025.
//

import Foundation

final class AppDependencyContainer {
    private var dependencies: [String: Any] = [:]
    
    func register<Service>(_ type: Service.Type, factory: @escaping () -> Service) {
        let key = String(describing: type)
        dependencies[key] = factory
    }
    
    func resolve<Service>(_ type: Service.Type) -> Service {
        let key = String(describing: type)
        if let instance = dependencies[key] as? Service {
            return instance
        } else if let factory = dependencies[key] as? () -> Service {
            let instance = factory()
            dependencies[key] = instance
            return instance
        }
        fatalError("No service registered for \(key)")
    }
}

extension AppDependencyContainer {
    func registerDependencies() {
// MARK: - Date
        register(DateDataProviderProtocol.self) {
            DateDataProvider()
        }
        
        register(DateRepositoryProtocol.self) {
            DateRepository(dateDataProvider: self.resolve(DateDataProviderProtocol.self))
        }
        
        register(DateUsecaseProtocol.self) {
            DateUsecase(dateRepository: self.resolve(DateRepositoryProtocol.self))
        }
// MARK: - Task
        register(TaskDataProviderProtocol.self) {
            TaskDataProvider()
        }
        
        register(TaskRepositoryProtocol.self) {
            TaskRepository(taskDataProvider: self.resolve(TaskDataProviderProtocol.self))
        }
        
        register(TaskUsecaseProtocol.self) {
            TaskUsecase(taskRepository: self.resolve(TaskRepositoryProtocol.self))
        }
       
// MARK: - MainViewViewModel
        register(MainViewViewModel.self) {
            MainViewViewModel(
                dateUsecase: self.resolve(DateUsecaseProtocol.self),
                taskUsecase: self.resolve(TaskUsecaseProtocol.self)
            )
        }
    }
}
