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
    
    /*
     Create a function called saveToPersistentStore(). This function will be responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application. You can implement this by doing the following:

     Create an instance of PropertyListEncoder.
     Inside of a do-try-catch block create a constant called booksData. Using the encode(value: ...) function of the property list encoder, encode the books array into Data.
     Call the write(to: URL) function on the data you encoded computed property. The url you pass in should be an unwrapped version of the readingListURL property.
     */
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
        let encoder = PropertyListEncoder()
        let booksdata = try encoder.encode(book)
            try booksdata.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
}
