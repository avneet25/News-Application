//
//  CollectionViewCell.swift
//  NewsApp
//
//  Created by Avneet Kaur on 2021-12-28.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    //langVC
    @IBOutlet weak var scriptLbl : UILabel!
    @IBOutlet weak var langLbl: UILabel!
    
    //countryVC
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    
    //categoryVC
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    
    //newslistVC
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
}

