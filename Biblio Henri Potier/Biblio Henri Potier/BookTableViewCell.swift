//
//  BookTableViewCell.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 13.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cover: UIImageView!;
    @IBOutlet weak var title: UILabel!;
    @IBOutlet weak var descript: UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
