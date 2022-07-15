//
//  Photos.swift
//  Navigation
//
//  Created by DmitriiG on 23.05.2022.
//

import Foundation

struct Photo {
    var name: String
}

final class PhotoData {
    
    var photoData = [Photo]()
    func createPhotoData(photo: Photo) {
        photoData.append(photo)
    }
}


