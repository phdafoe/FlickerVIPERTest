//
//  PhotoSearchInteractor.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorInput : class {
    func fetchAllPhotosFromDataManager(_ searchTag : String, page : Int)
}

protocol PhotoSearchInteractorOutput : class {
    func providedPhotos(_ photos : [FlickrPhotoModel], totalPage : Int)
    func serviceError(_ error : Error)
}

class PhotoSearchInteractor : PhotoSearchInteractorInput {
    
    //Colocamos el protocolo / Interface
    var APIDataManager : FlickPhotoSearchProtocol!
    weak var presenter : PhotoSearchInteractorOutput!
    
    func fetchAllPhotosFromDataManager(_ searchTag : String, page : Int){
        APIDataManager.fetchPhotoForSearchText(searchText: searchTag,
                                               page: page) { (error, totalPageCount, flickrPhotosArray) in
                                                if let photosDes = flickrPhotosArray{
                                                    self.presenter.providedPhotos(photosDes, totalPage: totalPageCount)
                                                }else if let errorDes = error{
                                                    self.presenter.serviceError(errorDes)
                                                }
        }
    }
}
