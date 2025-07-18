//
//  SearchBar.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isSearching: Bool = false
    var placeholder = "Поиск..."
    
    var body: some View {
        HStack (spacing: 0) {
            HStack (spacing: 0) {
                HStack {
                    TextField(placeholder, text: $searchText)
                        .font(.system(size: 17))
                        .padding(.leading, 8)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                }
                .padding()
                .cornerRadius(16)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .overlay(alignment: .center) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 17, height: 17)
                            .foregroundColor(searchText.count > 0 ? .ypBlack : .ypGray)
                        
                        Spacer()
                        
                        if searchText.count > 0 {
                            Button(action: { searchText = "" }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.ypGrayUniversal)
                                    .padding(.vertical)
                            })
                        }
                    }
                    .padding(.horizontal, 10)
                    .foregroundColor(.gray)
                }
            }
            .frame(height: 37)
            .background(.ypSearchBar)
            .cornerRadius(10)
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Отмена")
                        .foregroundColor(.blue)
                        .padding(.leading, 14)
                })
            }
        }
        .frame(height: 37)
        .padding(.horizontal, 16)
    }
}

