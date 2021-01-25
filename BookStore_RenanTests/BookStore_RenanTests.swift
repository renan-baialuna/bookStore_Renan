//
//  BookStore_RenanTests.swift
//  BookStore_RenanTests
//
//  Created by Renan Baialuna on 18/01/21.
//

import XCTest
@testable import BookStore_Renan

class BookStore_RenanTests: XCTestCase {
    var sut = VolumeManager()

    func testUrl() {
        let url = URL.booksUrl(index: 0)
        XCTAssertEqual("https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0", url?.absoluteString)
    }

    func testVolumeManager() throws {
        let data = Data("""
            {
              "items": [
                {
                  "id": "12345",
                  "volumeInfo": {
                    "title": "title",
                    "authors": [
                      "author"
                    ],
                    "description": "description",
                    "imageLinks": {
                      "smallThumbnail": "smallThumbnail",
                      "thumbnail": "thumbnail"
                    },
                  },
                  "saleInfo": {
                    "buyLink":"link"
                  }
                }
              ]
            }

""".utf8)
        let a = sut.parseJSONVolume(data)
        XCTAssertNotNil(a)
        XCTAssertEqual(a?.items[0].id, "12345")
        XCTAssertEqual(a?.items[0].volumeInfo.title, "title")
        XCTAssertEqual(a?.items[0].volumeInfo.authors?.count, 1)
        XCTAssertEqual(a?.items[0].volumeInfo.authors?[0], "author")
        XCTAssertEqual(a?.items[0].volumeInfo.description, "description")
    }



}
