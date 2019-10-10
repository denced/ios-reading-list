//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by denis cedeno on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookController: BookController?
     
    var book: Book?
      
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    @IBAction func saveButton(_ sender: Any) {
        guard book != nil else {
            let title = bookTitleTextField.text ?? ""
            let reason = reasonToReadTextView.text ?? ""
            bookController?.createBook(book: Book(title: title, reasonToRead: reason))
            
        navigationController?.popToRootViewController(animated: true)
            
            return
        }
            let title = bookTitleTextField.text
            let reason = reasonToReadTextView.text
            bookController?.updateTitleOrReasonToRead(for: book!, titleUpdate: title, reasonUpdate: reason)
            navigationController?.popToRootViewController(animated: true)
        
    }

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let book = book else {
            self.navigationItem.title = "Add a new book"
            return
            
        }
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        self.navigationItem.title = book.title
    }
    

}
