//
//  Volume.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 19/01/21.
import Foundation

// MARK: - Volumes
struct Volumes: Codable {
    let items: [Item]
}

struct Item: Codable {
    let kind: String
    let id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct SaleInfo: Codable {
    let buyLink: String?
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let description: String
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}