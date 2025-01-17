//
//  CustomSearchBar.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-01-15.
//


import SwiftUI
struct CustomSearchBar: View {
    @Binding var searchText: String
    
    @State var active = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText, onEditingChanged: { editing in
                                    withAnimation {
                                        active = editing
                                    }
                })
            }
            .padding(7)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .padding(.horizontal, active ? 0 : 50)
            Button("Cancel") {
                withAnimation {
                    active = false
                }
            }
            .opacity(active ? 1 : 0)
            .frame(width: active ? nil : 0)
        }
    }
}