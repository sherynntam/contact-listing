//
//  ContactDetailsViewModel.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 15/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import Foundation

protocol ContactDetailsViewModelDelegate: class
{
    
}

class ContactDetailsViewModel {
    var contact: Contact?
    var index: Int?
    var isEdit: Bool = false

    init(contact: Contact?, index: Int) {
        if  let contact = contact {
            self.contact = contact
            self.index = index
            isEdit = true
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var contactUpdated: (()->())?
    
    func updateContact(contact: Contact) {
        if self.isEdit {
            saveContact(contact: contact)
        }
        else {
            addContact(contact: contact)
        }
    }
    
    private func addContact(contact: Contact) {
        APIService.shared.addContact(contact: contact) { [weak self] (success, error) in
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self!.contactUpdated!()
            }
        }
    }
    
    private func saveContact(contact: Contact) {
        APIService.shared.saveContact(contact: contact, index: self.index!) { [weak self] (success, error) in
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self!.contactUpdated!()
            }
        }
    }
}
