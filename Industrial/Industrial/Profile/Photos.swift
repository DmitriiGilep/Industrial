//
//  Photos.swift
//  Navigation
//
//  Created by DmitriiG on 23.05.2022.
//

import Foundation
import UIKit

//struct Photo {
//    var name: String
//}

final class PhotoData {
    
    var imagesArray: [UIImage] = []
    
    // изменил методы - один для добавления массива картинок, полученных от observer, другой для добавления по имени из xcasset
    func createPhotoDataUIImage(photo: [UIImage]) {
        photo.forEach {
            imagesArray.append($0)
        }
    }
    
    func createPhotoDataInt(photo: [Int]) {
        photo.forEach {
            guard let image = UIImage(named: "\(String($0))") else { return }
            imagesArray.append(image)
        }
        
        
    }
}


