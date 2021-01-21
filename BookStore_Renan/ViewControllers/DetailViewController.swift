//
//  DetailViewController.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 20/01/21.
//

import UIKit

class DetailViewController: UIViewController {

    var book: VolumeWithImage!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var descriptionBookTextField: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyButton.layer.cornerRadius = 10
        buyButton.layer.masksToBounds = true
        
        if book.volume.saleInfo.buyLink == nil {
            buyButton.isHidden = true
        }
        
        self.title = book.volume.volumeInfo.title
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLable.text = book.volume.volumeInfo.authors?.joined(separator: " - ")
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

}
