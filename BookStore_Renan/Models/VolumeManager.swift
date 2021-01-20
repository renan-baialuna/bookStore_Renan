//
//  VolumeManager.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 19/01/21.
//

import Foundation
import UIKit

protocol manageVolumeData {
    func returnVolume(volume: VolumeWithImage)
}

struct VolumeManager {
    
    var delegate: manageVolumeData?
    
    func performSarch() {
        
        if let url = URL.booksUrl(index: 0) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    // error in request status
                }
                if let safeData = data {
                    if let information = self.parseJSONVolume(safeData) {
                        for volume in information.items {
                            getImage(volumeItem: volume)
                        }

                    } else {
                        // error getting info
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONVolume(_ rawData: Data) -> Volumes? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Volumes.self, from: rawData)
            return decodedData
        }
        catch {
            return nil
        }
    }
    
    func getImage(volumeItem: Item) {
        if let url = URL(string: volumeItem.volumeInfo.imageLinks.smallThumbnail) {

            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                }
                if let safeData = data {
                    if let downloadedImage = UIImage(data: safeData){
                        let volume = VolumeWithImage(volume: volumeItem, image: downloadedImage)
                        
                        delegate?.returnVolume(volume: volume)
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
