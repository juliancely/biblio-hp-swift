//
//  BusinessController.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 16.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import Foundation

class BusinessController {
    
    /*
     Get all books
     **/
    public class func getBooks(completionHandler:@escaping ([Book])->()) {
        ModelAPI.getBooks(completionHandler: { books in
            completionHandler(books)
        })
    }
    
    /*
     Compare offers for isbns and return the best one
     **/
    public class func getBestOffer(for books: [Book], completionHandler:@escaping (Offer)->()) {
        ModelAPI.getOffers(for: books, completionHandler: { offers in
            if let firstOffer = offers.first {
                let total = self.getTotalPrice(for: books)
                var best = firstOffer
                for offer in offers {
                    if offer.getReduction(for: total) > best.getReduction(for: total) {
                        best = offer
                    }
                }
                completionHandler(best)
            }
        })
    }
    
    /*
     Get the total price of the books
     **/
    public class func getTotalPrice(for books: [Book]) -> Double {
        var total: Double = 0
        for book in books {
            total += Double(book.getPrice())
        }
        return total
    }
}
