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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = book.volume.volumeInfo.title
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLable.text = book.volume.volumeInfo.authors?.joined(separator: " - ")
        bookImage.image = book.image
        descriptionBookTextField.text = book.volume.volumeInfo.description
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
