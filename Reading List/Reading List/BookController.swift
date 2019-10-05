//
//  BookController.swift
//  Reading List
//
//  Created by denis cedeno on 10/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
//Create a computed property called readingListURL: URL?. Inside of the computed property, you should:
//
//Get the user's document directory using the FileManager class.
//Create a filename string for the plist, such as "ReadingList.plist"
//Return a url that appends the filename string to the document directory. In doing this, you will create a full path wherein the Books in plist form will be stored on the user's device.
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask , appropriateFor: nil, create: true) else { return nil }

             return documents.appendingPathComponent("ReadingList.plist")
    }
    /*
     Create a computed property called readBooks: [Book]. Inside of the closure of the computed property, you will need to return an array of all of the Book objects from the books array whose hasBeenRead property is true. The easiest way to do that is by using the .filter higher-order function.
     */
    private var readBooks:[Book] {
        let readBooksArray = books.filter{$0.hasBeenRead == true}
        return readBooksArray
    }
    
    /*
     Create a similar computed property called unreadBooks: [Book] that does the same thing, except it returns an array of Books whose hasBeenRead property is false.
     */
    
    private var unreadBooks: [Book]{
        let unreadBooksArray = books.filter{$0.hasBeenRead == false}
        return unreadBooksArray
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
        let booksdata = try encoder.encode(books)
            try booksdata.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    
    /*
     Create a function called loadFromPersistentStore(). This function will be responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc. To implement this:

     Inside of a do-try-catch- block, unwrap the readingListURL property.
     Still inside of the block, use the Data(contentsOf: URL) initializer to get access to the property list form of the books. Assign this data you initialize to a constant.
     Initialize a PropertyListDecoder and assign it to a constant.
     Create a constant called decodedBooks. Set its value by calling the decode method on the property list decoder you just created, and passing in the type it should be decoded as, and the data constant you made a couple steps ago. (Hint: the type parameter to this function should be [Book].self)
     Set the value of the books property in the BookController to the decodedBooks you just made.
     In the catch block, you should make an error message that is descriptive of what happened
     */
        func loadFromPersistentStore() {
         guard let url = readingListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch{
            print("Error loading stars data: \(error)")
        }
    }
    
    /*
     Like always, we will need to make CRUD methods. As we're using a form of persistence, be sure to call saveToPersistentStore() at the end of each of these or the changes will not persist:

     Add a "Create" method that initializes a new Book object. In order to persist the newly created Book, call the saveToPersistentStore() method at the end of this function.
     Add a "Delete" method that passes in a Book object as a parameter, and removes it from the books array.
     We'll need two "Update" methods:
     One is to update a Book object's hasBeenRead property. Call it updateHasBeenRead(for book: Book). It should simply swap the hasBeenRead value from false to true and vice-versa.
     The other is to edit the Book's title and/or reasonToRead properties.
     */
    
    func createBook(named title: String, reasonToRead reason: String, hasBeenRead hasRead: Bool) -> Book{
        let book = Book(title: title, reasonToRead: reason, hasBeenRead: hasRead)
        books.append(book)
        
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book){
        let bookToDelete = book
        if let index = books.index(of: bookToDelete){
        books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book){
        guard let index = books.firstIndex(of: book) else {return}
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateTitleOrReasonToRead(for book: Book, titleUpdate: String?, reasonUpdate: String?){
        guard let index = books.firstIndex(of: book),
            let title = titleUpdate,
            let reason = reasonUpdate else {return}
        books[index].title = title
        books[index].reasonToRead = reason
        saveToPersistentStore()
    }
}
