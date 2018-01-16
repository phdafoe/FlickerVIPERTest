//
//  PhotoViewController.swift
//  FlickerVIPERTest
//
//  Created by Andres on 14/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

protocol PhotoViewControllerOutput {
    func fetchPhotos(_ searchTag : String, page : Int)
}

protocol PhotoViewControllerInput {
    func displayFetchedPhotos(_ photos : [FlickrPhotoModel], totalPages : Int)
    func displayErrorView(_ errorMessage : String)
}

class PhotoViewController: UIViewController, PhotoViewControllerInput  {
    
    
    //MARK: - Variables locales
    var presenter : PhotoViewControllerOutput!
    var arrayPhotos = [FlickrDataManager]()
    var currentPage = 1
    var totalPages = 1
    
    //MARK: - IBOutlets
    @IBOutlet weak var photoCollectionView : UICollectionView!
    
    
    //MARK: - LIFE VC
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoSearchAssembly.sharedInstance.configure(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSearchWith(CONSTANTES.PHOTO_SEARCH_KEY)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = CONSTANTES.PHOTO_SEARCH_KEY
    }
    
    //MARK: - UTILS
    func performSearchWith(_ searchText : String){
        presenter.fetchPhotos(searchText, page: currentPage)
    }
    
    //El presenter retornandonos con un resultado de fotos
    func displayFetchedPhotos(_ photos : [FlickrPhotoModel], totalPages : Int){
        self.arrayPhotos.append(contentsOf: photos)
        self.totalPages = totalPages
        
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    
    //Muestra el Error
    func displayErrorView(_ errorMessage : String){
        let refreshAlert = UIAlertController(title: CONSTANTES.ERRORS.ERROR_TITLE,
                                             message: CONSTANTES.ERRORS.ERROR_MESSAGE,
                                             preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: CONSTANTES.ERRORS.OK,
                                             style: .cancel, handler: nil))
        present(refreshAlert,
                animated: true,
                completion: nil)
    }
    
    
}
//MARK: - UICollectionViewDataSource
extension PhotoViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Photo cell + Loading cell
        if currentPage < totalPages{
            return arrayPhotos.count + 1
        }
        return arrayPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < arrayPhotos.count{
            return photoItemCell(collectionView, cellForItemAt: indexPath)
        }else{
            currentPage += 1
            performSearchWith(CONSTANTES.PHOTO_SEARCH_KEY)
            return photoLoadingCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func photoItemCell(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultReuseIdentifier, for: indexPath) as! PhotoItemCell
        return cell
    }
    
    func photoLoadingCell(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLoadingCell.defaultReuseIdentifier, for: indexPath) as! PhotoLoadingCell
        return cell
    }
   
}

//MARK: - UICollectionViewDelegate
extension PhotoViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO:
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize : CGSize
        let length  = (UIScreen.main.bounds.width) / 3 - 1
        
        
        if indexPath.row < arrayPhotos.count{
            itemSize = CGSize(width: length, height: length)
        }else{
            itemSize = CGSize(width: photoCollectionView.bounds.width, height: 50.0)
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    
}








