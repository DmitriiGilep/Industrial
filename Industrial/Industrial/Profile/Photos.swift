//
//  Photos.swift
//  Navigation
//
//  Created by DmitriiG on 23.05.2022.
//

import Foundation
import UIKit
import iOSIntPackage

//struct Photo {
//    var name: String
//}

final class PhotoData {
    
    let imageProcessor = ImageProcessor()

    var imagesArray: [UIImage] = []
        
    init(photo:[Int]) {
        createPhotoDataInt(photo: photo)
        applyFilterToImagesArrayWithTimer()
    }

    // изменил методы - один для добавления массива картинок, полученных от observer, другой для добавления по имени из xcasset
//    func createPhotoDataUIImage(photo: [UIImage]) {
//        photo.forEach {
//            imagesArray.append($0)
//        }
//    }
    
    func createPhotoDataInt(photo: [Int]) {
        photo.forEach {
            guard let image = UIImage(named: "\(String($0))") else { return }
            imagesArray.append(image)
        }
    }
    
    // включил метод по применению фильтра с completion по преобразованию массива в массив UIImage и присвоению его значения массиву imagesArray
    func applyFilterToImagesArrayWithTimer() {
    //замер времени на функцию
        let start = DispatchTime.now() // start time
    imageProcessor.processImagesOnThread(
        sourceImages: self.imagesArray,
        filter: .colorInvert,
        qos: .default) {
            outPutImages in
            self.imagesArray = outPutImages.map { cgImage -> UIImage in
                guard let image = cgImage else { return UIImage(named: "1")!
                }
                let filteredImage = UIImage(cgImage: image)
                return filteredImage
            }
        }
    let end = DispatchTime.now()   // end time
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
    let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
    print("!!!TIME FOR processImagesOnThread = \(timeInterval)")
    }
    
}


