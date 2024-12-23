//
//  MapClusterIconGenerator.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-12-23.
//

import Foundation
import GoogleMaps
import GoogleMapsUtils


class MapClusterIconGenerator: GMUDefaultClusterIconGenerator {
    
    //Custom cluster icon 
    override func icon(forSize size: UInt) -> UIImage {
        let baseSize = 60
        
        var iconSizeLevel  = 0
        
        var imageString = ""
        switch size {
        case 0 ... 10:
            imageString = "cluster_10_or_less"
        case 11 ... 20:
            imageString = "cluster_20_or_less"
            iconSizeLevel = 1
        case 21 ... 50:
            imageString = "cluster_50_or_less"
            iconSizeLevel = 2
        case 51 ... 100:
            imageString = "cluster_100_or_less"
            iconSizeLevel = 3
        case 101 ... 500:
            imageString = "cluster_500_or_less"
            iconSizeLevel = 4
        case 501 ... 1000:
            imageString = "cluster_1000_or_less"
            iconSizeLevel = 5
        default:
            imageString = "cluster_max"
            iconSizeLevel = 6
        }
        
        //Makes sure that the icon grows bigger when it has more items
        let iconSize = baseSize + (iconSizeLevel * 5)
        
        //Gets the correct icon and scales it to the correct size
        let formatedUiImage = MapIconFormatting.resizeImage(image: UIImage(named: imageString)!, scaledToSize: CGSize(width: iconSize, height: iconSize))
        
        //Adds the text of the # of items to the icon
        return addTextToImage(image: formatedUiImage, text: Int64(size).formatted())
    }
    
    private func addTextToImage(image: UIImage, text: String) -> UIImage {
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = text
        label.font = .boldSystemFont(ofSize: 20)
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithText!
    }
}
