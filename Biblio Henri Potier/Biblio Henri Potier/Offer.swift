//
//  Offer.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 16.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import Foundation

class Offer {
    
    private var type: String!
    private var value: Double!
    private var sliceValue: Double?
    
    init(value: Double) {
        self.value = value
    }
    
    init(dict: NSDictionary) {
        if let type = dict["type"] as? String {
            self.type = type
        }
        if let value = dict["value"] as? Double {
            self.value = value
        }
        if let sliceValue = dict["sliceValue"] as? Double? {
            self.sliceValue = sliceValue
        }
    }
    
    public func getReduction(for price: Double) -> Double {
        switch self.type {
        case "percentage":
            return price * value / 100
        case "minus":
            return value
        case "slice":
            return Double(Int(price) / 100 * Int(value))
        default:
            return 0
        }
    }
}
