//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by DmitriiG on 20.05.2022.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: Photo? {
        didSet {
            photoImageView.image = UIImage(named: "\(photo?.name ?? "")")
        }
    }
    
    private let photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUP()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        self.contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            self.photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }
}
