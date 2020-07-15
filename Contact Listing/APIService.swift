//
//  APIService.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 13/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network Connection"
    case permissionDenied = "Permission denied"
}

protocol APIServiceProtocol {
    func fetchAllContacts( complete: @escaping ( _ success: Bool, _ contacts: [Contact],
        _ error: APIError? )->() )
    
    func addContact( contact: Contact, complete: @escaping ( _ success: Bool, _ error: APIError? )->() )
    
    func saveContact( contact: Contact, index: Int, complete: @escaping ( _ success: Bool, _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    
    static let shared = APIService()
        
    var contacts: [Contact] = []
    
    func fetchAllContacts( complete: @escaping ( _ success: Bool, _ contacts: [Contact], _ error: APIError? )->() ) {
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "data", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let contacts = try! decoder.decode(Array<Contact>.self, from: data)
            self.contacts = contacts
            complete(true, contacts, nil)
        }
    }
    
    func addContact( contact: Contact, complete: @escaping ( _ success: Bool, _ error: APIError? )->() ) {
        self.contacts.append(contact)
        
            DispatchQueue.global().async {
                let path = Bundle.main.path(forResource: "data", ofType: "json")!

                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let data = try? encoder.encode(self.contacts),
                    let jsonString = String(data: data, encoding: .utf8) {
                  try! jsonString.write(to: URL(fileURLWithPath: path), atomically: false, encoding: .utf8)
                }
                complete(true, nil)
            }
        }
    
    func saveContact( contact: Contact, index: Int, complete: @escaping ( _ success: Bool, _ error: APIError? )->() ) {
        self.contacts[index] = contact
        
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "data", ofType: "json")!
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            if let data = try? encoder.encode(self.contacts),
                let jsonString = String(data: data, encoding: .utf8) {
                try! jsonString.write(to: URL(fileURLWithPath: path), atomically: false, encoding: .utf8)
            }
            complete(true, nil)
        }
    }
}
