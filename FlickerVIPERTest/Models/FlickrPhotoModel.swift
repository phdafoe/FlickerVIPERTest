//
//  FlickrPhotoModel.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

struct FlickrPhotoModel {

    let photoId : String
    let farm : Int
    let secret : String
    let server : String
    let title : String
    
    var photoURL : URL{
        return flickrImageURL()
    }
    
    var largePhotoURL : URL{
        return flickrImageURL(size: "b")
    }
    
    private func flickrImageURL(size : String = "m") -> URL{
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg")!
    }
    
}
