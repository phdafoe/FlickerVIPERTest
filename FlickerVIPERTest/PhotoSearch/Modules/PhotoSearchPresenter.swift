//
//  PhotoSearchPresenter.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

protocol PhotoSearchPresenterInput : PhotoViewControllerOutput {
    
}

class PhotoSearchPresenter : PhotoSearchPresenterInput {
    
    weak var view : PhotoViewControllerInput!
    var interactor : PhotoSearchInteractorInput!
    
    //El Presenter le dice al Interactor  que el ViewController necesita photos
    func fetchPhotos(_ searchTag : String, page : Int){
        self.interactor.fetchAllPhotosFromDataManager(searchTag, page: page)
    }
    
    //El servicio retorna las fotos y el Interactor pasa los datos  al presenter mientras hace que la vista se muestre luego
    func providedPhotos(_ photos : [FlickrPhotoModel], totalPage : Int){
        self.view.displayFetchedPhotos(photos, totalPages: totalPage)
    }
    
    //Muestra el error del servicio
    func serviceError(_ error : Error){
        self.serviceError(CONSTANTES.ERRORS.ERROR_DEFAULT as! Error)
    }
}
