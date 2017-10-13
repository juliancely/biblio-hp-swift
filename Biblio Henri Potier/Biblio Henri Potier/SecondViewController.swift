//
//  SecondViewController.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 12.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Commandez"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let array = NSArray(array: ["c30968db-cb1d-442e-ad0f-80e37c077f89","fcd1e6fa-a63f-4f75-9da4-b560020b6acc","c30968db-cb1d-442e-ad0f-80e37c077f89"]);
        ModelAPI.getOffers(for: array, completionHandler: { offers in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

