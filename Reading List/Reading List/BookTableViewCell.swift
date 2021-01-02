//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by denis cedeno on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    var book: Book? {
        didSet{
            updateViews()
        }
    }
    

    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBAction func checkBoxAction(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    
    
    func updateViews() {
        guard let book = book else { return }

        bookLabel.text = book.title
        
        if book.hasBeenRead == true {
            checkBoxButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    
}


