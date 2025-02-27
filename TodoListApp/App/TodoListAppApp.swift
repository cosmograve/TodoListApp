//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    
    private let container: AppDependencyContainer = {
        let container = AppDependencyContainer()
        container.registerDependencies()
        return container
    }()
    
    @StateObject private var viewModel: MainViewViewModel
    
    init() {
        let viewModel: any MainViewViewModelProtocol = container.resolve((any MainViewViewModelProtocol).self)
        self._viewModel = StateObject(wrappedValue: viewModel as! MainViewViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
