//
//  CustomSearchBar.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-01-15.
//


import SwiftUI
struct CustomSearchBar: View {
    @Binding var searchText: String
    
    @Binding var searchActive: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText, onEditingChanged: { editing in
                                    withAnimation {
                                        searchActive = editing
                                    }
                })
            }
            .padding(7)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .padding(.horizontal, searchActive ? 0 : 50)
            Button("Cancel") {
                withAnimation {
                    searchActive = false
                }
            }
            .opacity(searchActive ? 1 : 0)
            .frame(width: searchActive ? nil : 0)
        }
    }
}
