//
//  ContactTableViewCell.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 13/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactImage: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
