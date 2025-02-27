//
//  View+Extension.swift
//  TodoListApp
//
//  Created by Алексей on 27.02.2025.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
