//
//  FirstViewController.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 12.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import UIKit
import AlamofireImage

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var booksTable: UITableView!
    
    private var books: [Book] = []
    private let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Wording.titleSelect
        
        booksTable.delegate = self
        booksTable.dataSource = self
        
        BusinessController.getBooks(completionHandler: { books in
            self.books = books
            self.booksTable.reloadData()
        })
    }
    
    public func deselectRows() {
        for i in 0 ... books.count - 1 {
            booksTable.deselectRow(at: IndexPath(row: i, section: 0), animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        if let url = URL(string: books[indexPath.row].getCover()) {
            cell.cover.af_setImage(withURL: url)
        }
        cell.title.text = books[indexPath.row].getTitle()
        cell.price.text = books[indexPath.row].getPrice().description + " €"
        cell.descript.text = books[indexPath.row].getSynopsis().firstObject as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.add(book: books[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        appDelegate.delete(book: books[indexPath.row])
    }
}

