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
    @FocusState var isFocused: Bool?
    
    var body: some View {
        
        TextField("Search for Historical Sites...",
                  text: $searchText,
                  onEditingChanged: { editting in
            if editting{
                searchActive = editting
            }
            
        })
//        TextField("",
//                  text: $searchText,
//                  prompt: Text("Search for Historical Sites...")
//            .foregroundColor(.gray)
//                  
//        )
//        
        
        .lineLimit(1)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(50)
        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal, 0)
        .padding(.vertical, 1)
        
        //Unfortunately, isFocused currently does not work inside a ToolbarItem item.
        //So instead I have to use the decapriated onEditingChanged
//        .focused($isFocused)
//        .onChange(of: isFocused){ focus in
//            searchActive = focus
//        }
    }
}
