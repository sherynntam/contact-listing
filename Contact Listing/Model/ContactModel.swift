//
//  ContactModel.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 13/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import Foundation

struct Contact: Decodable {

    let id: String
    let firstName: String
    let lastName: String
    let email: String?
    let phone: String?

    init(id: String, firstName: String, lastName: String, email: String? = nil, phone:String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
    
}
