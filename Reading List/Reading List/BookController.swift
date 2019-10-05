//
//  BookController.swift
//  Reading List
//
//  Created by denis cedeno on 10/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var book: [Book] = []
    
//Create a computed property called readingListURL: URL?. Inside of the computed property, you should:
//
//Get the user's document directory using the FileManager class.
//Create a filename string for the plist, such as "ReadingList.plist"
//Return a url that appends the filename string to the document directory. In doing this, you will create a full path wherein the Books in plist form will be stored on the user's device.
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask , appropriateFor: nil, create: true) else { return nil }
             // /Apps/Stars/Documents/stars.plist
             return documents.appendingPathComponent("ReadingList.plist")
    }
}
