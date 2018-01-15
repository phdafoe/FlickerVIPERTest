//
//  PhotoSearchPresenter.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

protocol PhotoSearchPresenterInput : PhotoSearchViewControllerOutput {
    
}

class PhotoSearchPresenter : PhotoSearchPresenterInput {
    
    var interactor : PhotoSearchInteractorInput!
    
    //El Presenter le dice al Interactor  que el ViewController necesita photos
    func fetchPhotos(_ searchTag : String, page : Int){
        self.interactor.fetchAllPhotosFromDataManager(searchTag, page: page)
    }
}
