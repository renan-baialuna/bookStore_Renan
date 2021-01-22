//
//  DetailViewController.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 20/01/21.
//

import UIKit

class DetailViewController: UIViewController {

    var book: VolumeWithImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var descriptionBookTextField: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isFavorite: Bool = false
    var favorite: Favorites?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyButton.layer.cornerRadius = 10
        buyButton.layer.masksToBounds = true
        
        
        if book.volume.saleInfo.buyLink == nil {
            buyButton.isHidden = true
        }
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = book.volume.volumeInfo.title
        authorLable.text = book.volume.volumeInfo.authors?.joined(separator: " - ")
        bookImage.image = book.image
        descriptionBookTextField.text = book.volume.volumeInfo.description
        
        

        if let foo = appDelegate.favorites.first(where: {$0.id == book.volume.id}) {
            view.backgroundColor = UIColor.yellow
            isFavorite = true
            self.favorite = foo
        }
        chageFavoriteUI(isFavorite: isFavorite)
    }
    
    @IBAction func buyAction() {
        if let urlString = book.volume.saleInfo.buyLink {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func newFavorite() {
        saveFavorite()
        
    }
    
    func saveFavorite() {
        let newFavorite = Favorites(context: context)
        newFavorite.id = book.volume.id
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteFavorite() {
        if let fav = favorite {
            self.context.delete(fav)
        }
        do {
            try context.save()
        } catch {
            
        }
    }
    
    @IBAction func favoriteBook() {
        if isFavorite {
            deleteFavorite()
            
        } else {
            saveFavorite()
        }
        isFavorite = !isFavorite
        chageFavoriteUI(isFavorite: isFavorite)
        
    }
    
    func chageFavoriteUI(isFavorite: Bool) {
        if isFavorite {
            self.favoriteButton.image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        } else {
            self.favoriteButton.image = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        }
    }

}
