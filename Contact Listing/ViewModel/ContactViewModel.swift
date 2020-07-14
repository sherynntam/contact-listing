//
//  ContactViewModel.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 13/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import Foundation

class ContactViewModel {
    let apiService: APIServiceProtocol
    
    var contacts: [Contact] = [] {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var reloadTableView: (()->())?
    var showAlertClosure: (()->())?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        initFetch()
    }
    
    func initFetch() {
        apiService.fetchAllContacts { [weak self] (success, contacts, error) in
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.contacts = contacts
            }
        }
    }
}
