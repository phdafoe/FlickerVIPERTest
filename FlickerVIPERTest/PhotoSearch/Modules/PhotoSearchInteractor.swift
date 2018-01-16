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

class PhotoSearchInteractor : PhotoSearchInteractorInput {
    
    //Colocamos el protocolo / Interface
    var APIDataManager : FlickPhotoSearchProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTag : String, page : Int){
        APIDataManager.fetchPhotoForSearchText(searchText: searchTag,
                                               page: page) { (error, totalPageCount, flickrPhotosArray) in
                                                if let photosDes = flickrPhotosArray{
                                                    //TODO
                                                    print(photosDes)
                                                }else if let errorDes = error{
                                                    //TODO
                                                    print(errorDes)
                                                }
        }
    }
}
