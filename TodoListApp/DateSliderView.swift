//
//  DateSliderView.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

struct DateSliderView<DateViewContent: View>: View {
    @EnvironmentObject private var weekManager: DateManager
    @State private var activeTab: Int = 1
    @State private var position = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero
    @State private var direction: SliderTimeDirection = .unknown
    @Namespace private var sliderAnimation
    let dateViewContent: (_ week: WeekModel) -> DateViewContent
    
    init(@ViewBuilder dateViewContent: @escaping(_ week: WeekModel) -> DateViewContent) {
        self.dateViewContent = dateViewContent
    }
    
    var body: some View {
        TabView(selection: $activeTab){
            dateViewContent(weekManager.weeks[0])
                .frame(maxWidth: .infinity)
                .tag(0)
            dateViewContent(weekManager.weeks[1])
                .frame(maxWidth: .infinity)
                .tag(1)
                .onDisappear() {
                    guard direction != .unknown else { return }
                    weekManager.update(to: direction)
                    direction = .unknown
                    activeTab = 1
                }
            dateViewContent(weekManager.weeks[2])
                .frame(maxWidth: .infinity)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: activeTab) { _, newValue in
            if newValue == 0 {
                direction = .past
            } else if newValue == 2 {
                direction = .future
            }
        }
    }
}

#Preview {
    DateSliderView() { week in
        DateView(week: week)
    }
    .environmentObject(DateManager())
}
