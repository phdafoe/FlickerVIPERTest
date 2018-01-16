//
//  FlickDataManager.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol FlickPhotoSearchInterface : class {
    func fetchPhotoForSearchText(searchText : String, page : Int, completion : @escaping errorIntArrayCompletion)
}

class FlickrDataManager : FlickPhotoSearchInterface{
    
    static let sharedInstante = FlickrDataManager()
    
    func fetchPhotoForSearchText(searchText : String, page : Int, completion : @escaping errorIntArrayCompletion){
        let escapedSearhText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let format = CONSTANTES.FLICKR_API.TAG_SEARCH_FORMAT
        let arguments : [CVarArg] = [CONSTANTES.FLICKR_API.API_KEY, escapedSearhText, page]
        let photosURL = String(format: format, arguments: arguments)
        let url = URL(string: photosURL)!
        let request = URLRequest(url: url)
        let searchTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print("Error fetching photos: \(String(describing: error))")
                completion(error, 0, nil)
            }
            do{
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? customDictionary
                guard let results = resultsDictionary else {return}
                if let statusCode = results[CONSTANTES.FLICKR_API_METADATA_KEY.FEALURE_STATUS_CODE] as? Int{
                    if statusCode == CONSTANTES.ERROS.INVALID_ACCESS_ERROR{
                        let invalideAccessError = NSError(domain: "FlickrAPIDomain",
                                                          code: statusCode,
                                                          userInfo: nil)
                        completion(invalideAccessError, 0, nil)
                        return
                    }
                }
                guard let photoContainer = resultsDictionary!["photos"] as? customDictionary else {return}
                guard let totalPageCountString = photoContainer["total"] as? String else {return}
                guard let totalPageCount = Int(totalPageCountString as String) else {return}
                guard let photosArray = photoContainer["photo"] as? [customDictionary] else {return}
                
                let flickrPhotosArray : [FlickrPhotoModel] = photosArray.map({ (photosDictionary) -> FlickrPhotoModel in
                    let photoId = photosDictionary["id"] as? String ?? ""
                    let farm = photosDictionary["farm"] as? Int ?? 0
                    let secret = photosDictionary["secret"] as? String ?? ""
                    let server = photosDictionary["server"] as? String ?? ""
                    let title = photosDictionary["title"] as? String ?? ""
                    let flickrPhoto = FlickrPhotoModel(photoId: photoId,
                                                       farm: farm,
                                                       secret: secret,
                                                       server: server,
                                                       title: title)
                    return flickrPhoto
                })
                completion(nil, totalPageCount, flickrPhotosArray)
            }catch let error{
                print("Error parsing JSON\(error)")
                completion(error, 0, nil)
            }
        }
        searchTask.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
