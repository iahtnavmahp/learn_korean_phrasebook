//
//  GreetingCollectionViewCell.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import UIKit

class GreetingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
