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
    //@FocusState var isFocused: Bool?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for Historic Sites...",
                      text: $searchText,
                      onEditingChanged: { editting in
                if editting{
                    searchActive = editting
                }
                
            })
            .lineLimit(1)
            //.padding(.horizontal, 5)
            .padding(.vertical, 10)
        }
        .padding(.horizontal)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(50)
        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.gray, lineWidth: 1))
        .frame(maxWidth: .infinity)
//        .padding(.horizontal, 0)
//        .padding(.vertical, 1)
        
       
        
    }
}
