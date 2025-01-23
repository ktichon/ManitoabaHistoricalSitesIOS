import SwiftUI
import CoreLocation

struct DisplaySearchResults: View {
    var searchResults: [HistoricalSite]
    var userLocation: CLLocationCoordinate2D
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(searchResults, id: \.id){ site in
                    HStack{
                        VStack(alignment: .leading){
                            Text(site.name)
                                .lineLimit(2)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            
                            
                            Text(site.formatedAddress())
                                .lineLimit(2)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        VStack{
                            Text(SiteInfoFormatting.getDisplayDistance(coord1: site.position, coord2: userLocation))
                        }
                        .padding(5)
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    Divider()
                        .background(Color.secondary)
                }
                
            }.padding(5)
                
        }
    }
}