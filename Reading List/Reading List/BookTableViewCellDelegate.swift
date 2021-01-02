//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by denis cedeno on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
