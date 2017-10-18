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
    @IBOutlet weak var orderButton: UIButton!
    
    private var selectedBooks: [Book] = []
    private var bestOffer: Offer!
    private let appDelegate = (UIApplication.shared.delegate as! AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Wording.titleBuy
        
        summaryTable.delegate = self
        summaryTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedBooks = appDelegate.getSelectedBooks()
        summaryTable.reloadData()
        BusinessController.getBestOffer(for: selectedBooks, completionHandler: { bestOffer in
            self.bestOffer = bestOffer
            self.summaryTable.reloadData()
        })
        orderButton.isEnabled = selectedBooks.count > 0
        orderButton.backgroundColor = selectedBooks.count > 0 ? .darkGray : .lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedBooks.count > 0 ? 4 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 || section == 3 {
            return 1
        }
        else {
            return selectedBooks.count > 0 ? selectedBooks.count : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Summary Title
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTitleTableViewCell") as! SummaryTitleTableViewCell
            return cell
        }
        // Book Details View Cells
        else if indexPath.section == 1 {
            if selectedBooks.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
                if let url = URL(string: selectedBooks[indexPath.row].getCover()) {
                    cell.cover.af_setImage(withURL: url)
                }
                cell.title.text = selectedBooks[indexPath.row].getTitle()
                cell.price.text = selectedBooks[indexPath.row].getPrice().description + " €"
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnySelectedTableViewCell")
                return cell!
            }
        }
        // Subtotal View Cells
        else if indexPath.section == 2 && self.bestOffer != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubTotalTableViewCell")
            cell?.textLabel?.text = Wording.subTotal + " : " + Int(BusinessController.getTotalPrice(for: selectedBooks)).description + " €        " + Wording.reduction + " : " + self.bestOffer.getReduction(for: BusinessController.getTotalPrice(for: selectedBooks)).description
            return cell!
        }
        // Total View Cells
        else if indexPath.section == 3 && self.bestOffer != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell")
            cell?.textLabel?.text = Wording.total + " : " + (BusinessController.getTotalPrice(for: selectedBooks) - self.bestOffer.getReduction(for: BusinessController.getTotalPrice(for: selectedBooks))).description + " €"
            return cell!
        }
        else {
            return UITableViewCell()
        }
    }
    
    @IBAction func order(_ sender: Any) {
        
        // Validation alert
        let alertController = UIAlertController(title: Wording.alertTitle, message: Wording.alertMsg, preferredStyle: .alert);
        let yesAction = UIAlertAction(title: Wording.yes, style: .default) { (_) -> Void in
            
            // Confirmation alert
            let alertController = UIAlertController(title: nil, message: Wording.validated, preferredStyle: .alert);
            let okAction = UIAlertAction(title: Wording.ok, style: .default, handler: nil);
            alertController.addAction(okAction);
            self.present(alertController, animated: false, completion: {
                self.appDelegate.deleteBooks()
                self.appDelegate.setTabBarIndex(index: 0)
            })
        }
        alertController.addAction(yesAction);
        let noAction = UIAlertAction(title: Wording.no, style: .default, handler: nil);
        alertController.addAction(noAction);
        self.present(alertController, animated: false, completion: nil);
    }
}

