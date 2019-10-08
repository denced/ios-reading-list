//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by denis cedeno on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    var book: Book?
    
    /*
     Create a new Swift file called "BookTableViewCellDelegate.swift", and create a protocol with the same name (minus the ".swift", of course).
     Add a function called func toggleHasBeenRead(for cell: BookTableViewCell)
     Back in the BookTableViewCell class, add a weak var delegate: BookTableViewCellDelegate? variable.
     Call the delegate property's toggleHasBeenRead(for cell: ...) function in the action of the button.
     */
    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBAction func checkBoxAction(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    
    
    func updateViews() {
        guard let book = book else {
            return
        }
        bookLabel.text = book.title
        
        if book.hasBeenRead == true {
            checkBoxButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    
}


