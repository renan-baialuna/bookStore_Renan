//
//  Volume.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 19/01/21.
import Foundation
import UIKit

// MARK: - Volumes
struct Volumes: Codable {
    let items: [Item]
}

struct Item: Codable {
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct SaleInfo: Codable {
    let buyLink: String?
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct VolumeWithImage {
    let volume: Item
    let image: UIImage
}
