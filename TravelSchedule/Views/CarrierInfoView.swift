//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @ObservedObject var carriersVM: CarriersViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack {
                    AsyncImage(url: URL(string: carriersVM.carrier?.logo ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.ypBlackUniversal)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.ypBlackUniversal)
                        }
                    }
                    .frame(width: 343, height: 104)
                    .background(.ypWhiteUniversal)
                    .clipShape(.rect(cornerRadius: 24))
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(carriersVM.carrier?.title ?? "информации нет")
                        .font(.system(size: 24, weight: .bold))
                    VStack(alignment: .leading, spacing: 0) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                        Text(carriersVM.carrier?.email ?? "информации нет")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypBlueUniversal)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                        Text(carriersVM.carrier?.phone ?? "информации нет")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypBlueUniversal)
                    }
                }
                Spacer()
                    .toolbarRole(.editor)
                    .navigationTitle("Информация о перевозчике")
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
        }
    }
    
}

#Preview {
    CarrierInfoView(carriersVM: CarriersViewModel())
}
