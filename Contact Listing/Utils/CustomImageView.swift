//
//  CustomImageView.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 15/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        self.backgroundColor = UIColor(rgb: 0xFF8C00)
    }
}
