//
//  MostImageCell.swift
//  assignment4-game
//
//  Created by Parinya Termkasipanich on 24/9/2565 BE.
//

import UIKit

class MostImageCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageShow: UIImageView!
    
    func config(imgName:String) {
        ImageShow.image = UIImage(named: imgName)
    }
}
