//
//  PhotoItemCell.swift
//  FlickerVIPERTest
//
//  Created by Andres on 16/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell, ReuseIdentifierInterface {
    
    //MARK: - IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
}
