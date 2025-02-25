//
//  DateHeaderView.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

struct DateHeaderView: View {
    @EnvironmentObject private var dateManager: DateManager
    var body: some View {
        ZStack {
            VStack {
                dateHeader()
                DateSliderView() { week in
                    DateView(week: week)
                }
                .frame(height: 60, alignment: .top)
                Divider()
                HStack {
                    Spacer()
                    Text(dateManager.selectedDate.toString(format: "EEEE, dd MMMM, yyyy"))
                        .font(.system(size: 10, design: .rounded))
                        .foregroundStyle(.gray)
                }
            }
        }
    }
    
    @ViewBuilder
    private func dateHeader() -> some View {
        HStack {
            VStack(alignment: .listRowSeparatorLeading, spacing: 0) {
                Text("Hi!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(4)
                
                Text(dateManager.selectedDate == Calendar.current.startOfDay(for: Date()) ? "What's up today?" : "Planning for future? ")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .padding(4)
            }
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(dateManager.selectedDate.monthToString())
                    .font(.system(size: 10))
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                Button {
                    withAnimation(.linear(duration: 0.1)) {
                        dateManager.selectToday()
                    }
                } label: {
                    Text("Today")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.purple)
                        .cornerRadius(4)
                }
            }
        }
    }
}

#Preview {
    DateHeaderView()
        .environmentObject(DateManager())
}
