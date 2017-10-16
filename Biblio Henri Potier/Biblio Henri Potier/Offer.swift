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
    private var value: Int!
    private var sliceValue: Int?
    
    init(value: Int) {
        self.value = value
    }
    
    init(dict: NSDictionary) {
        if let type = dict["type"] as? String {
            self.type = type
        }
        if let value = dict["value"] as? Int {
            self.value = value
        }
        if let sliceValue = dict["sliceValue"] as? Int? {
            self.sliceValue = sliceValue
        }
    }
    
    public func getValue() -> Int {
        return self.value
    }
    
    public func getSliceValue() -> Int? {
        return self.sliceValue
    }
}
