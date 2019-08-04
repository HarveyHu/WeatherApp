//
//  UIImage+Extension.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit

extension UIImage {
        class func getCachedImage(imageName: String) -> UIImage? {
            let imagePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
            if FileManager.default.fileExists(atPath: imagePath) {
                if let image = UIImage(contentsOfFile: imagePath + "/" + imageName) {
                    return image
                }
            }
            return nil
        }
        
        class func cacheImage(imageName: String, image: UIImage) -> Bool {
            guard let range = imageName.range(of: ".") else {
                print("have no extFileName")
                return false
            }
            
            var imageData: Data?
            let extFileName = imageName[range.upperBound...].lowercased()
            if extFileName == "png" {
                imageData = image.pngData()
            } else if extFileName == "jpg" {
                imageData = image.jpegData(compressionQuality: 0)
            }
            
            if let data = imageData {
                let imagePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
                do {
                    try data.write(to: URL(fileURLWithPath: imagePath + "/" + imageName), options: .atomicWrite)
                } catch let error {
                    print("\(error)")
                    return false
                }
                return true
            }
            return false
        }
}
