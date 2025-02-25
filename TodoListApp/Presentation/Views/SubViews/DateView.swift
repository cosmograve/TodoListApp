//
//  DateView.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

struct DateView: View {
    @EnvironmentObject private var weekManager: DateManager
    var week: WeekModel
    var body: some View {
        HStack {
            ForEach(0..<7) { index in
                VStack {
                    Text(week.dates[index].toString(format: "EEE").uppercased())
                        .font(.system(size: 10))
                        .fontWeight(week.dates[index].isSameDay(as: week.referenceDate) ? .bold : .light)
                        .foregroundStyle(week.dates[index].isSameDay(as: week.referenceDate) ? .white : .black)
                        .frame(maxWidth: .infinity)
                    Spacer()
                        .frame(height: 4)
                    Text(week.dates[index].toString(format: "d"))
                        .font(.system(size: 10))
                        .fontWeight(week.dates[index].isSameDay(as: week.referenceDate) ? .bold : .light)
                        .foregroundStyle(week.dates[index].isSameDay(as: week.referenceDate) ? .white : .black)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(week.dates[index].isSameDay(as: week.referenceDate) ? .purple : .clear)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) {
                        weekManager.selectedDate = week.dates[index]
                    }
                }
            }
        }
    }
}

#Preview {
    DateView(week: .init(index: 1, dates: [
            Date().yesterday.yesterday.yesterday,
            Date().yesterday.yesterday,
            Date().yesterday,
            Date(),
            Date().tomorrow,
            Date().tomorrow.tomorrow,
            Date().tomorrow.tomorrow.tomorrow,
        ], referenceDate: Date())
    )
}
