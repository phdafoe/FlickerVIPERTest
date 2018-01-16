//
//  PhotoSearchPresenter.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

protocol PhotoSearchPresenterInterface : PhotoSearchViewControllerInterface {
    
}

class PhotoSearchPresenter : PhotoSearchPresenterInterface {
    
    var interactor : PhotoSearchInteractorInterface!
    
    //El Presenter le dice al Interactor  que el ViewController necesita photos
    func fetchPhotos(_ searchTag : String, page : Int){
        self.interactor.fetchAllPhotosFromDataManager(searchTag, page: page)
    }
}
