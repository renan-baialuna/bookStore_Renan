//
//  ViewController.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 18/01/21.
//

import UIKit


class BooksCollectionViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var books: [VolumeWithImage] = []
    var booksFavorited: [VolumeWithImage] = []
    var pageLoaded = 0
    var onlyFavorites = false
    
    @IBOutlet weak var booksCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var favoritesFilterButton: UIBarButtonItem!
    
    var volumeManager = VolumeManager()
    var dataMager = FavoritesManager(appDelegate: (UIApplication.shared.delegate as! AppDelegate))
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.booksCollection.delegate = self
        self.booksCollection.dataSource = self
        volumeManager.delegate = self
        volumeManager.performSearch(index: pageLoaded, books: books)
        setFlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.booksCollection.reloadData()
        if onlyFavorites {
            self.getAllFavoriteBooks()
        }
    }
    
    func getAllFavoriteBooks() {
        booksFavorited = []
        for book in books {
            if dataMager.getFavorite(book.volume.id) != nil {
                booksFavorited.append(book)
            }
        }
    }
    
// MARK: - set up UI
    
    func setFlow() {
        let space:CGFloat = 5.0
        let dimension = ((view.frame.size.width - 20) - (2 * space)) / 2

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 2 * space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension * 5 / 3)
    }
    
    func changeButtonIcont(_ status: Bool) {
        if status {
            favoritesFilterButton.image = UIImage(systemName: "star.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        } else {
            favoritesFilterButton.image = UIImage(systemName: "star.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        }
    }
    
    @IBAction func displayFavorites() {
        onlyFavorites = !onlyFavorites
        self.getAllFavoriteBooks()
        changeButtonIcont(onlyFavorites)
        self.booksCollection.reloadData()
    }
    
    func createErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.volumeManager.performSearch(index: self.pageLoaded, books: self.books)
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

// MARK: - Collection view control

extension BooksCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if onlyFavorites {
            return booksFavorited.count
        } else {
            return books.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        var volume: VolumeWithImage
        if onlyFavorites {
            volume = booksFavorited[indexPath.row]
        } else {
            volume = books[indexPath.row]
        }
        

        if dataMager.getFavorite(volume.volume.id) != nil {
            cell.favoriteImage.isHidden = false
        } else {
            cell.favoriteImage.isHidden = true
        }
        
        cell.label.text = volume.volume.volumeInfo.title
        cell.image.image = volume.image
        cell.backView.layer.cornerRadius = 10
        cell.backView.layer.masksToBounds = true
        
        cell.label.adjustsFontSizeToFitWidth = true
        cell.label.minimumScaleFactor = 0.3
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == books.count - 1 ) && !onlyFavorites {
            self.pageLoaded += 1
            volumeManager.performSearch(index: pageLoaded, books: books)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if onlyFavorites {
            controller.book = booksFavorited[indexPath.row]
        } else {
            controller.book = books[indexPath.row]
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - API delegate implementation

extension BooksCollectionViewController: manageVolumeData {
    func returnError(status: errorMessage) {
        let title: String
        let message: String
        switch status {
        case .problemConnecting:
            title = "Error de Conexão"
            message = "Problemas ao conectar, verifique sua conexão"
        case .problemInResponse:
            title = "Error"
            message = "Problemas com a resposta dos dados"
        case .problemWithCode(code: let code):
            title = "Error"
            message = "Problemas com a comunicação com o backend, código: \(code)"
        case .problemTranslatingData:
            title = "Error de Tradução"
            message = "problema conectando com a tradução de dados do backend"
            
        }
        
        createErrorAlert(title: title, message: message)
        
    }
    
    func returnVolume(volume: VolumeWithImage) {
        
        if books.filter({ (el) -> Bool in
            return el.volume.id == volume.volume.id
        }).count == 0 {
            DispatchQueue.main.sync {
                self.books.append(volume)
                booksCollection.reloadData()
            }
        }
    }
    
    
}
