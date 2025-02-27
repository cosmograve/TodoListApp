//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    
    private let container = AppDependencyContainer()
    
    @StateObject private var viewModel: MainViewViewModel
    
    init() {
        container.registerDependencies()
        let resolvedViewModel: MainViewViewModel = container.resolve(MainViewViewModel.self)
        self._viewModel = StateObject(wrappedValue: resolvedViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
