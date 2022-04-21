//
//  CatalogueTableViewCell.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 13.04.2021.
//

import UIKit
class CatalogueTableViewCell: UITableViewCell {
    @IBOutlet var catalogueTitle: UILabel!
    @IBOutlet var catalogueCover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
