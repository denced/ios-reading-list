//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by denis cedeno on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController,
BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    

    let bookController: BookController = BookController()
    
    func bookFor(indexPath: IndexPath) -> Book{
        if indexPath.section == 0 {
                   return bookController.readBooks[indexPath.row]
               } else {
                   return bookController.unreadBooks[indexPath.row]
               }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
           tableView.reloadData()
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        }else if section == 1 {
            return bookController.unreadBooks.count
        }else{
            return 0
        }
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? BookTableViewCell else {fatalError("A star cell was not found")}
       
        cell.delegate = self
        let book = bookController.books[indexPath.row]
        cell.book = book
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        }else if section == 1 {
            return "Unread Books"
        }else{
            return ""
        }
    }


    // Fill out the commit editingStyle function. You only need to worry about the .delete case.
     
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            bookController.deleteBook(book: <#T##Book#>)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        tableView.reloadData()
//        }
//    }
    



    // MARK: - Navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addDetailViewSegue"{
        guard let addBook = segue.destination as? BookDetailViewController else {return}
       addBook.bookController = bookController
        
    } else if segue.identifier == "viewDetailSegue" {
        guard let viewBook = segue.destination as? BookDetailViewController,
            let indexPath = sender as? BookTableViewCell else { return }
        viewBook.bookController = bookController
        viewBook.book = indexPath.book
    }
  }
}
