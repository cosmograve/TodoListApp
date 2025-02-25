//
//  Task.swift
//  TodoListApp
//
//  Created by Алексей on 23.02.2025.
//

import Foundation

struct Task: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var isCompleted: Bool = false
}
