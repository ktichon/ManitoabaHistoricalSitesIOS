//
//  DisplayTableView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-04-03.
//


import SwiftUI

//Displays table
struct DisplayTableView: View {
    var siteTable : SiteTable
    
    var body: some View {
        VStack(alignment: .leading){
            if let tablename = siteTable.name{
                Text(tablename)
                    .font(.title)
            }
            
            //Basicly, there are some tables that have a bunch of columns, with a single line of data.
            //There are also tables that have not much columns, but contain multiple lines of text.
            //Grid doesn't calculate hight correctly inside a scroll view, and forces the data to appear on one line.
            //This if statement is a compromise
            //If there are more than two columns, it is put into a scroll view
            //If not, then it stays out of the scroll view, preserving the multi-line functionality
            if siteTable.numOfColumns > 2{
                ScrollView(.horizontal){
                    DisplayTableGridView(tableRowData: SiteInfoFormatting.splitTableDataIntoRows(tableData: siteTable.contentMarkdown))
                }
            } else {
                DisplayTableGridView(tableRowData: SiteInfoFormatting.splitTableDataIntoRows(tableData: siteTable.contentMarkdown))
            }
        }
    }
}
