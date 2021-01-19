//
//  ViewController.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 18/01/21.
//

import UIKit


class BooksCollectionViewController: UIViewController {
    var books = [1, 2, 3, 4]
    @IBOutlet weak var booksCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.booksCollection.delegate = self
        self.booksCollection.dataSource = self
        // Do any additional setup after loading the view.
        booksCollection.reloadData()
    }
    


}


extension BooksCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.label.text = "\(books[indexPath.row])"
        
        return cell
    }
    
    
}
