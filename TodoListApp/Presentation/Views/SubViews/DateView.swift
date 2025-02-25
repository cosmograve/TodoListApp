//
//  DateView.swift
//  TodoListApp
//
//  Created by Алексей on 21.02.2025.
//

import SwiftUI

struct DateView: View {
    @ObservedObject var viewModel: MainViewViewModel
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
                        viewModel.selectTheDay(with: week.dates[index])
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewViewModel(dateUsecase: DateUsecase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUsecase: TaskUsecase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider()))))
}

