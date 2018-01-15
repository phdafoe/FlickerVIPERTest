//
//  PhotoViewController.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

protocol PhotoSearchViewControllerOutput {
    func fetchPhotos(_ searchTag : String, page : Int)
}

class PhotoViewController: UIViewController {
    
    var presenter : PhotoSearchViewControllerOutput!
    var arrayPhotos = [FlickrDataManager]()
    var currentPage = 1
    var totalPages = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoSearchAssembly.sharedInstance.configure(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSearchWith(CONSTANTES.PHOTO_SEARCH_KEY)
    }
    
    func performSearchWith(_ searchText : String){
        presenter.fetchPhotos(searchText, page: currentPage)
    }
    
    
}
