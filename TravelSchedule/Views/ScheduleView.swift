//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                ZStack {
                    Color.ypBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            SelectDestinationView(
                                settlement: viewModel.fromSettlement?.title ?? "",
                                station: viewModel.fromStation?.title ?? "",
                                placeholder: "Откуда"
                            )
                            .onTapGesture {
                                viewModel.addPath(with: Route.selectFromCityView)
                            }
                            SelectDestinationView(
                                settlement: viewModel.toSettlement?.title ?? "",
                                station: viewModel.toStation?.title ?? "",
                                placeholder: "Куда"
                            )
                            .onTapGesture {
                                viewModel.addPath(with: Route.selectToCityView)
                            }
                        }
                        .frame(height: 96)
                        .font(.system(size: 17, weight: .regular))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                        )
                        
                        Button {
                            viewModel.changeDirection()
                        } label: {
                            Image("change")
                                .frame(width: 36, height: 36)
                                .background(.white)
                                .cornerRadius(40)
                        }
                        
                    }
                    .padding(16)
                }
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .frame(height: 128)
                
                Button {
                    viewModel.isLoading = true
                    Task {
                        await viewModel.search()
                    }
                    viewModel.addPath(with: Route.carriersView)
                } label: {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 60)
                        .background(.ypBlue)
                        .cornerRadius(16)
                }
                .opacity(viewModel.setSearchButtonEnable() ? 1 : 0 )
            }
        }
    }
}

#Preview {
    ScheduleView()
        .environmentObject(ScheduleViewModel())
}
