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
    public class func getOffers(for books: [Book], completionHandler:@escaping ([Offer])->()) {
        let isbns: NSMutableArray = NSMutableArray()
        for book in books {
            isbns.add(book.getISBN())
        }
        let isbnString = isbns.componentsJoined(by: ",")
        Alamofire.request("http://henri-potier.xebia.fr/books/\(isbnString)/commercialOffers", method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                if let offersDict = response.result.value as? NSDictionary {
                    if let offersArray = offersDict.object(forKey: "offers") as? NSArray {
                        var offers: [Offer] = []
                        for offerData in offersArray {
                            if let offerDict = offerData as? NSDictionary {
                                offers.append(Offer(dict: offerDict))
                            }
                        }
                        completionHandler(offers)
                    }
                }
            }
        }
    }
}
