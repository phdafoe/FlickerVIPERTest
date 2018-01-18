//
//  PhotoSearchAssembly.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

class PhotoSearchAssembly{
    
    static let sharedInstance = PhotoSearchAssembly()
    
    func configure(_ viewController : PhotoViewController){
        let APIDataManager = FlickrDataManager()
        let interactor = PhotoSearchInteractor()
        let presenter = PhotoSearchPresenter()
        let router = PhotoSearchRoot()
        router.view = viewController
        presenter.router = router
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.APIDataManager = APIDataManager
    }
}
