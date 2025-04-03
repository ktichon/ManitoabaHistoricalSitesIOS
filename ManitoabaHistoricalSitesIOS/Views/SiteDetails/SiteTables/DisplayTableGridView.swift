//
//  DisplayTableGridView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-04-03.
//

import SwiftUI

//Displays the site grid
struct DisplayTableGridView: View {
    var tableRowData: [String]
    var body: some View {
        VStack{
            Grid (alignment: .leading, horizontalSpacing: 0, verticalSpacing: 0){
                ForEach(tableRowData, id: \.self){ currentRow in
                    GridRow{
                        DisplayTableRowView(
                            columnDetailList: SiteInfoFormatting.splitRowDataIntoColumn(rowData: currentRow),
                            itemPadding: 5)
                        
                    }
                    //Because I can't just add a border, I manually make a line after each row
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .frame(height: 1)
                        .overlay(Color.primary)
                }
                
            }
            .border(Color.primary, width: 1)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }
}


