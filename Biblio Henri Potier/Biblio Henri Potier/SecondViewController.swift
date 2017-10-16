//
//  SecondViewController.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 12.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var summaryTable: UITableView!
    
    private var selectedBooks: [Book] = []
    private var bestOffer: Offer!
    private let appDelegate = (UIApplication.shared.delegate as! AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Commandez"
        
        summaryTable.delegate = self
        summaryTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedBooks = appDelegate.getSelectedBooks()
        BusinessController.getBestOffer(for: selectedBooks, completionHandler: { bestOffer in
            self.bestOffer = bestOffer
            self.summaryTable.reloadData()
            print("BO: \(bestOffer.getValue())")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 || section == 2 ? 1 : selectedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTitleTableViewCell") as! SummaryTitleTableViewCell
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let url = URL(string: selectedBooks[indexPath.row].getCover()) {
                cell.cover.af_setImage(withURL: url)
            }
            cell.title.text = selectedBooks[indexPath.row].getTitle()
            cell.price.text = selectedBooks[indexPath.row].getPrice().description + " €"
            return cell
        }
        else if indexPath.section == 2 && self.bestOffer != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell")
            cell?.textLabel?.text = self.bestOffer.getValue().description
            return cell!
        }
        else {
            return UITableViewCell()
        }
    }
}

