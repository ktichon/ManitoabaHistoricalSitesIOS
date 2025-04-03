//
//  DisplayTableRowView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-04-03.
//

import SwiftUI

//Displays one row of a table
struct DisplayTableRowView: View {
    var columnDetailList: [String]
    var itemPadding: CGFloat
    var body: some View {
        ForEach(columnDetailList, id: \.self){ currentData in
            HStack{
                if columnDetailList.firstIndex(of: currentData) != 0{
                    //Because simply adding a border around didn't work, I have added a divider befoe every item, with exception of the first one
                    Divider()
                        .gridCellUnsizedAxes(.vertical)
                        .frame(width: 1)
                        .overlay(Color.primary)
                    
                    
                    
                }
                
                Text(LocalizedStringKey(currentData))
                    .font(.body)
                    .padding(itemPadding)
                    .multilineTextAlignment(.center)
            }
        }
    }
}


