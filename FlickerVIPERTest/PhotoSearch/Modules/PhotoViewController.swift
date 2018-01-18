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
    func goToPhotoDetailScreen()
    func passDataToNextViewController(_ customSegue : UIStoryboardSegue)
}

protocol PhotoViewControllerInput {
    func displayFetchedPhotos(_ photos : [FlickrPhotoModel], totalPages : Int)
    func displayErrorView(_ errorMessage : String)
    func showWaitingView()
    func hideWaitingView()
    func getTotalPhotosCount() -> Int
}

class PhotoViewController: UIViewController, PhotoViewControllerInput  {
    
    
    //MARK: - Variables locales
    var presenter : PhotoViewControllerOutput!
    var arrayPhotos : [FlickrPhotoModel] = []
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
    
    //Muestra Vista de Actividad
    func showWaitingView(){
        let alert = UIAlertController(title: nil,
                                             message: CONSTANTES.ERRORS.MESSAGE_WAITING,
                                             preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    //Oculta la vista de Actividad
    func hideWaitingView(){
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    //Obtiene el numero total de fotos
    func getTotalPhotosCount() -> Int{
        return arrayPhotos.count
    }
    
    //MARK: - Navigation con Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.presenter.passDataToNextViewController(segue)
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
        
        let fickerPhoto = arrayPhotos[indexPath.row]
        cell.photoImageView.alpha = 0
        cell.photoImageView.sd_setImage(with: fickerPhoto.photoURL) { (imadeData, errorData, cacheData, url) in
            cell.photoImageView.image = imadeData
            UIView.animate(withDuration: 0.2, animations: {
                cell.photoImageView.alpha = 1
            })
        }
        
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
        self.presenter.goToPhotoDetailScreen()
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








