//
//  PhotosViewController.swift
//  Navigation
//
//  Created by DmitriiG on 20.05.2022.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {
    
    private let imagePublisherFacade = ImagePublisherFacade()
    
    // массив имен картинок из xcasset (если делать через
    private let imagesNamesArrayXCasset = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    // экземпляр класса, в котором будет массив для хранения всех картинок imagesArray
    private var photoData = PhotoData()
    
    private var photosCollectionViewFlowLayout: UICollectionViewFlowLayout = {
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
    
    private lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionViewFlowLayout)
        photos.dataSource = self
        photos.delegate = self
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        photos.translatesAutoresizingMaskIntoConstraints = false
        return photos
    }()
    
    private func setUP() {
        self.title = "Photo Gallery"
        // загружаю картинки из xcasset в единый массив photoData
        photoData.createPhotoDataInt(photo: imagesNamesArrayXCasset)
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
        // подписал на протокол = добавление контроллера в массив observer
        imagePublisherFacade.subscribe(self)
        // вызов функции по добавлению в массив observer картинок для последующей его передачи в функцию receive
        imagePublisherFacade.addImagesWithTimer(time: 5, repeat: 10)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageLibrarySubscriber {
    
    
    
    func receive(images: [UIImage]) {
        
        // добавил в общий массив картинок полученные images
        photoData.createPhotoDataUIImage(photo: images)
        // обновил ячейки, чтобы добавить новые картинки
        photosCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        //поменял порядок получения картинок в ячейки  через общий массив
        let imageForCell = photoData.imagesArray[indexPath.row]
        cell.imageForCell = imageForCell
 
        let imageProcessor = ImageProcessor()
        if let image = cell.photoImageView.image { imageProcessor.processImage(sourceImage: image, filter: .chrome, completion: {filteredPicture in cell.photoImageView.image = filteredPicture})
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPadding: CGFloat = 8*4
        let numberOfCellInRow : CGFloat = 3
        let collectionCellWidth: CGFloat = (self.view.frame.size.width - totalPadding) / numberOfCellInRow
        return CGSize(width: collectionCellWidth , height: collectionCellWidth*0.7)
        
    }
    
}
