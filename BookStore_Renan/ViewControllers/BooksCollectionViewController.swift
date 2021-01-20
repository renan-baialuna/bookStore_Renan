//
//  ViewController.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 18/01/21.
//

import UIKit


class BooksCollectionViewController: UIViewController {
    var books: [VolumeWithImage] = []
    var pageLoaded = 0
    
    @IBOutlet weak var booksCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var volumeManager = VolumeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.booksCollection.delegate = self
        self.booksCollection.dataSource = self
        volumeManager.delegate = self
        
        volumeManager.performSearch(index: pageLoaded)
        setFlow()
    }
    
    
// MARK: - set up UI
    
    func setFlow() {
        let space:CGFloat = 5.0
        let dimension = ((view.frame.size.width - 20) - (2 * space)) / 2

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 2 * space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension * 5 / 3)
    }
    


}


extension BooksCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        let volume = books[indexPath.row]
        
        cell.label.text = volume.volume.volumeInfo.title
        cell.image.image = volume.image
        cell.backView.layer.cornerRadius = 10
        cell.backView.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == books.count - 1 ) {
            self.pageLoaded += 1
            volumeManager.performSearch(index: pageLoaded)
        }
    }
    
    
}

extension BooksCollectionViewController: manageVolumeData {
    func returnVolume(volume: VolumeWithImage) {
        
        DispatchQueue.main.sync {
            self.books.append(volume)
            booksCollection.reloadData()
        }
    }
    
    
}
