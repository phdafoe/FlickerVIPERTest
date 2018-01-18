//
//  PhotoSearchPresenter.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

protocol PhotoSearchPresenterInput : PhotoViewControllerOutput, PhotoSearchInteractorOutput {
    
}

class PhotoSearchPresenter : PhotoSearchPresenterInput {
    
    var view : PhotoViewControllerInput!
    var interactor : PhotoSearchInteractorInput!
    var router : PhotoSearchRootInput!
    
    //El Presenter le dice al Interactor  que el ViewController necesita photos
    func fetchPhotos(_ searchTag : String, page : Int){
        if view.getTotalPhotosCount() == 0{
            view.showWaitingView()
        }
        self.interactor.fetchAllPhotosFromDataManager(searchTag, page: page)
    }
    
    //El servicio retorna las fotos y el Interactor pasa los datos  al presenter mientras hace que la vista se muestre luego
    func providedPhotos(_ photos : [FlickrPhotoModel], totalPage : Int){
        view.hideWaitingView()
        self.view.displayFetchedPhotos(photos, totalPages: totalPage)
    }
    
    //Muestra el error del servicio
    func serviceError(_ error : Error){
        self.view.displayErrorView(CONSTANTES.ERRORS.ERROR_DEFAULT)
    }
    
    //MARK: - Vamos a la vista detalle
    func goToPhotoDetailScreen(){
        self.router.navigatePhotoDetail()
    }
    
    func passDataToNextViewController(_ customSegue: UIStoryboardSegue) {
        self.router.passDataToNextViewController(customSegue)
    }
}

