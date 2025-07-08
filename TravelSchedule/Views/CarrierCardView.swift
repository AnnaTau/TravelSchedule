//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct CarrierCardView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    private let segment: Segments
    private let startDate: String
    private let departureTime: String
    private let arrivalTime: String
    private let travelTime: Double
    
    init(segmentInfo: Segments, startDate: String, departureTime: String, arrivalTime: String) {
        self.segment = segmentInfo
        travelTime = (segment.duration ?? 0)/3600
        self.startDate = startDate
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
    }
    
    var body: some View {
        ZStack {
            Color.ypLightGray
            VStack(spacing: 14) {
                HStack(alignment: .top, spacing: 18) {
                    AsyncImage(url: URL(string: segment.thread?.carrier?.logo ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            ProgressView()
                        }
                    }
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text(segment.thread?.carrier?.title ?? "информации нет")
                            .font(.system(size: 17, weight: .regular))
                        Text("C пересадкой в: \(segment.transfers?.first?.title ?? "")")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypRedUniversal)
                            .lineLimit(2)
                            .opacity( segment.has_transfers ?? false ? 1 : 0)
                    }
                    Spacer()
                    Text(startDate)
                        .font(.system(size: 12, weight: .regular))
                }
                .foregroundStyle(.ypBlackUniversal)
                
                HStack {
                    Text(departureTime)
                    VStack {
                        Divider()
                            .frame(height: 1)
                            .overlay(.ypGrayUniversal)
                    }
                    Text("\(travelTime, specifier: "%.0f") часов")
                        .font(.system(size: 12, weight: .regular))
                    VStack {
                        Divider()
                            .frame(height: 1)
                            .overlay(.ypGrayUniversal)
                    }
                    Text(arrivalTime)
                }
                .foregroundStyle(.ypBlackUniversal)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
}

#Preview {
    CarrierCardView(segmentInfo: Segments(), startDate: "", departureTime: "", arrivalTime: "")
        .environmentObject(ScheduleViewModel())
}
