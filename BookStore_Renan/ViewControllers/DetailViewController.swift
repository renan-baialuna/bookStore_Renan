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
    }
    
    @IBAction func buyAction() {
        if let urlString = book.volume.saleInfo.buyLink {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func favoriteBook() {
        self.favoriteButton.image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    }

}
