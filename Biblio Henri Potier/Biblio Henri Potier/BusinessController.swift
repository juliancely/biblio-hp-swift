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
     Compare offers for isbns and return the best one
     **/
    public class func getBestOffer(for books: [Book], completionHandler:@escaping (Offer)->()) {
        ModelAPI.getOffers(for: books, completionHandler: { offers in
            if let firstOffer = offers.first {
                var best = firstOffer
                for offer in offers {
                    if let sliceVal = offer.getSliceValue() {
                        let total = self.getTotalPrice(for: books)
                        if sliceVal >= total {
                            if offer.getValue() > best.getValue() {
                                best = offer
                            }
                        }
                    }
                    else if offer.getValue() > best.getValue() {
                        best = offer
                    }
                }
                completionHandler(best)
            }
        })
    }
    
    public class func getTotalPrice(for books: [Book]) -> Int {
        var total: Int = 0
        for book in books {
            total += book.getPrice()
        }
        return total
    }
}
