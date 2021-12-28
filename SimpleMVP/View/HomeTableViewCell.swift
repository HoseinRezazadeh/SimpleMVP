//
//  HomeTableViewCell.swift
//  SimpleMVP
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 12/28/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var yearLable: UILabel!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var titelLable: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    public func configuration( titel : String , type : String , year : String , ImgaeURLString : String ) {
       
        yearLable.text = year
        typeLable.text = type
        titelLable.text = titel
        FetchAndCashImage.fetchImageFromURL(UIImageView: movieImage, stringURL: ImgaeURLString )
    }

}
