//
//  CustomTextField.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 15/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.returnKeyType = UIReturnKeyType.next
    }
}
