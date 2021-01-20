//
//  ViewController.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 18/01/21.
//

import UIKit


class BooksCollectionViewController: UIViewController {
    var books: [Item] = []
    
    
    @IBOutlet weak var booksCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var volumeManager = VolumeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.booksCollection.delegate = self
        self.booksCollection.dataSource = self
        volumeManager.delegate = self
        
        volumeManager.performSarch()
        setFlow()
    }
    
    
// MARK: - set up UI
    
    func setFlow() {
        let space:CGFloat = 5.0
        let dimension = ((view.frame.size.width - 20) - (2 * space)) / 2

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension * 5 / 3)
    }
    


}


extension BooksCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.label.text = "???"
        
        return cell
    }
    
    
}

extension BooksCollectionViewController: manageVolumeData {
    func returnData(volumes: [Item]) {
        self.books = volumes
        DispatchQueue.main.sync {
            booksCollection.reloadData()
        }
        
    }
    
    
}
