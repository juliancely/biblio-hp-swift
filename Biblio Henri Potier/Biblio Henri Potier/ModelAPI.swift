//
//  ModelAPI.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 13.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import Foundation
import Alamofire

class ModelAPI {
    
    /*
     Get all books
    **/
    public class func getBooks(completionHandler:@escaping ([Book])->()) {
        Alamofire.request("http://henri-potier.xebia.fr/books", method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                if let booksArray = response.result.value as? NSArray {
                    var books: [Book] = []
                    for bookData in booksArray {
                        if let bookDict = bookData as? NSDictionary {
                            books.append(Book(dict: bookDict))
                        }
                    }
                    completionHandler(books)
                }
            }
        }
    }
    
    /*
     Get offers for isbns
     **/
    public class func getOffers(for isbns: NSArray, completionHandler:@escaping ([Book])->()) {
        let isbnString = isbns.componentsJoined(by: ",")
        Alamofire.request("http://henri-potier.xebia.fr/books/\(isbnString)/commercialOffers", method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                if let booksArray = response.result.value as? NSArray {
                    var books: [Book] = []
                    for bookData in booksArray {
                        if let bookDict = bookData as? NSDictionary {
                            books.append(Book(dict: bookDict))
                        }
                    }
                    completionHandler(books)
                }
            }
        }
    }
}
