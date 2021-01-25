//
//  TestBookCollection.swift
//  BookStore_RenanTests
//
//  Created by Renan Baialuna on 25/01/21.
//

import XCTest
@testable import BookStore_Renan

class TestBookCollection: XCTestCase {
    var storyboard: UIStoryboard!
    var vc: BooksCollectionViewController!
    
    
    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "BooksCollectionViewController") as! BooksCollectionViewController
    }

    func testCollection() throws {
        let volumeInfo = VolumeInfo(title: "title", authors: ["author"], description: "description", imageLinks: ImageLinks(smallThumbnail: "small", thumbnail: "big"))
        let volume = VolumeWithImage(volume: Item(id: "id", volumeInfo: volumeInfo, saleInfo: SaleInfo(buyLink: "buyLink")), image: UIImage(named: "appstore")!)
        let list: [VolumeWithImage] = [volume]
        
        
        vc.books = list
        vc.loadView()
        XCTAssertEqual(vc.books.count, 1)
        
        vc.viewDidLoad()
        vc.viewWillAppear(true)
        XCTAssertEqual(vc.booksCollection.numberOfItems(inSection: 0), 1)
    }

}
