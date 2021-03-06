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
    func returnError(status: errorMessage)
}

struct VolumeManager {
    
    var delegate: manageVolumeData?
    
    func performSearch(index: Int, books: [VolumeWithImage]) {
        
        if let url = URL.booksUrl(index: index) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    delegate?.returnError(status: .problemConnecting)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode >= 400 {
                        delegate?.returnError(status: .problemWithCode(code: httpResponse.statusCode))
                    }
                }
                
                if let safeData = data {
                    if let information = self.parseJSONVolume(safeData) {
                        for volume in information.items {
                            if books.filter({ (el) -> Bool in
                                return el.volume.id == volume.id
                            }).count == 0 {
                                getImage(volumeItem: volume)
                            }
                        }
                    } else {
                        delegate?.returnError(status: .problemTranslatingData)
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
                    print(error?.localizedDescription)
                    
                } else {
                    if let safeData = data {
                        if let downloadedImage = UIImage(data: safeData){
                            let volume = VolumeWithImage(volume: volumeItem, image: downloadedImage)
                            
                            delegate?.returnVolume(volume: volume)
                        } else {
                            print("no image translated")
                        }
                    } else {
                        print("no image")
                    }
                }
                
            }
            task.resume()
        }
    }
    
    
}
