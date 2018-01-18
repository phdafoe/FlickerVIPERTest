//
//  PhotoSearchRoot.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

protocol PhotoSearchRootInput: class {
    func navigatePhotoDetail()
    func passDataToNextViewController(_ customSegue : UIStoryboardSegue)
}

class PhotoSearchRoot : PhotoSearchRootInput{
    
    var view : PhotoViewController!
    
    //MARK: - Navigation
    func navigatePhotoDetail(){
        view.performSegue(withIdentifier: "ShowDetailVC", sender: nil)
    }
    
    func passDataToNextViewController(_ customSegue: UIStoryboardSegue){
        if customSegue.identifier == "ShowDetailVC"{
            self.passDataToShowNextViewController(customSegue)
        }
    }
    
    //MARK: - Navega al otro modulo
    func passDataToShowNextViewController(_ segue : UIStoryboardSegue){
        if let selectedIndexPath = view.photoCollectionView.indexPathsForSelectedItems?.first{
            let selectedPhotoModel = view.arrayPhotos[selectedIndexPath.row]
            let showDetailViewController = segue.destination as! PhotoDetailViewController
            
            showDetailViewController
        }
    }
    
}
