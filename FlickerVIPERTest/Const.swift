//
//  Const.swift
//  FlickerVIPERTest
//
//  Created by Andres on 15/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

typealias errorIntArrayCompletion = (Error?, Int, [FlickrPhotoModel]?) -> ()
typealias customDictionary = [String : Any]

let CONSTANTES = Constantes()


struct Constantes {
    let PHOTO_SEARCH_KEY = "party"
    let ERROS = Errors()
    let FLICKR_API_METADATA_KEY = FlickrAPIMetadataKeys()
    let FLICKR_API = FlickrAPI()
}

struct Errors {
    let INVALID_ACCESS_ERROR = 100
}

struct FlickrAPIMetadataKeys {
    let FEALURE_STATUS_CODE = "code"
}

struct FlickrAPI {
    let API_KEY = "91e82bda4e57744a6c535881f8d4a28c"
    let TAG_SEARCH_FORMAT = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
}

