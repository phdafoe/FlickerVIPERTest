//
//  PhotoViewController.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        FlickrDataManager.sharedInstante.fetchPhotoForSearchText(searchText: CONSTANTES.PHOTO_SEARCH_KEY,
                                                                 page: 1) { (errorData, page, photos) in
                                                                    print(photos)
        }
        
    }
    
    
}
