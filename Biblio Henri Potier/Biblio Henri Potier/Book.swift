//
//  Book.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 12.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import Foundation

class Book {
    
    private var title: String!
    private var cover: String!
    private var isbn: String!
    private var price: Int!
    private var synopsis: NSArray!
    
    init(dict: NSDictionary) {
        if let title = dict["title"] as? String {
            self.title = title
        }
        if let cover = dict["cover"] as? String {
            self.cover = cover
        }
        if let isbn = dict["isbn"] as? String {
            self.isbn = isbn
        }
        if let price = dict["price"] as? Int {
            self.price = price
        }
        if let synopsis = dict["synopsis"] as? NSArray {
            self.synopsis = synopsis
        }
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func getCover() -> String {
        return self.cover
    }
    
    public func getISBN() -> String {
        return self.isbn
    }
    
    public func getPrice() -> Int {
        return self.price
    }
    
    public func getSynopsis() -> NSArray {
        return self.synopsis
    }
}
