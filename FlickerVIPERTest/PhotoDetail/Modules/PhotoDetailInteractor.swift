//
//  PhotoDetailInteractor.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

protocol PhotoDetailInteractorOutput : class {
    func configuredPhotModel(_ photoModel : FlickrPhotoModel)
}

protocol PhotoDetailInteractorInput : class {
    func sendLoadedPhotoImage(_ imageData : UIImage)
    func loadUIImageFromUrl()
    func getPhotoImageTitle() -> String
}

class PhotoDetailInteractor : PhotoDetailInteractorInput{
    
    var presenter : PhotoDetailInteractorOutput!
    var photoModel : FlickrPhotoModel?
    var imageDataManager : FlickrPhotoLoadImageProtocol!
    
    func configuredPhotModel(_ photoModel : FlickrPhotoModel){
        self.photoModel = photoModel
    }
    
    func loadUIImageFromUrl(){
        imageDataManager.loadImageFromUlr(self.photoModel!.largePhotoURL) { (imageData, errorData) in
            if let imageDataDes = imageData{
                self.presenter.sendLoadedPhotoImage(imageDataDes)
            }else{
                print("\(String(describing: errorData))")
            }
        }
    }
    
    func getPhotoImageTitle() -> String {
        if let titleDes = self.photoModel?.title{
            return titleDes
        }
        return ""
    }
    
}




