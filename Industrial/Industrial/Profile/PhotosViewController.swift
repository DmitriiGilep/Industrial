//
//  PhotosViewController.swift
//  Navigation
//
//  Created by DmitriiG on 20.05.2022.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    var photoData: PhotoData = {
        let photo = PhotoData()
        photo.createPhotoData(photo: Photo(name: "1"))
        photo.createPhotoData(photo: Photo(name: "2"))
        photo.createPhotoData(photo: Photo(name: "3"))
        photo.createPhotoData(photo: Photo(name: "4"))
        photo.createPhotoData(photo: Photo(name: "5"))
        photo.createPhotoData(photo: Photo(name: "6"))
        photo.createPhotoData(photo: Photo(name: "7"))
        photo.createPhotoData(photo: Photo(name: "8"))
        photo.createPhotoData(photo: Photo(name: "9"))
        photo.createPhotoData(photo: Photo(name: "10"))
        photo.createPhotoData(photo: Photo(name: "11"))
        photo.createPhotoData(photo: Photo(name: "12"))
        photo.createPhotoData(photo: Photo(name: "13"))
        photo.createPhotoData(photo: Photo(name: "14"))
        photo.createPhotoData(photo: Photo(name: "15"))
        photo.createPhotoData(photo: Photo(name: "16"))
        photo.createPhotoData(photo: Photo(name: "17"))
        photo.createPhotoData(photo: Photo(name: "18"))
        photo.createPhotoData(photo: Photo(name: "19"))
        photo.createPhotoData(photo: Photo(name: "20"))
        return photo
    }()
    
    var photosCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 8,
            left: 8,
            bottom: 8,
            right: 8)
        return layout
    } ()
    
    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionViewFlowLayout)
        photos.dataSource = self
        photos.delegate = self
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        photos.translatesAutoresizingMaskIntoConstraints = false
        return photos
    }()
    
    private func setUP() {
        self.title = "Photo Gallery"
        self.view.addSubview(photosCollectionView)
        
        NSLayoutConstraint.activate([
            
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = photoData.photoData[indexPath.row]
        cell.photo = data
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPadding: CGFloat = 8*4
        let numberOfCellInRow : CGFloat = 3
        let collectionCellWidth: CGFloat = (self.view.frame.size.width - totalPadding) / numberOfCellInRow
        return CGSize(width: collectionCellWidth , height: collectionCellWidth*0.7)
        
    }
    
}
