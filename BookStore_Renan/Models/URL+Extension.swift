//
//  URL+Extension.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 20/01/21.
//

import Foundation

extension URL {
    static func booksUrl(index: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [
            URLQueryItem(name: "q", value: "ios"),
            URLQueryItem(name: "maxResults", value: String(20)),
            URLQueryItem(name: "startIndex", value: String(index))
        ]
        
        return components.url
    }
}
