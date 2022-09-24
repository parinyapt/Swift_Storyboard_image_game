//
//  ImageCell.swift
//  assignment4-game
//
//  Created by Parinya Termkasipanich on 24/9/2565 BE.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageShow: UIImageView!
    
    func config(imgName:String) {
        imageShow.image = UIImage(named:imgName)
    }
}
