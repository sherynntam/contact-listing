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
}

class APIService: APIServiceProtocol {
    func fetchAllContacts( complete: @escaping ( _ success: Bool, _ contacts: [Contact], _ error: APIError? )->() ) {
        DispatchQueue.global().async {
            // simulate a waiting time for fetching
            sleep(1)
            let path = Bundle.main.path(forResource: "data", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let contacts = try! decoder.decode(Array<Contact>.self, from: data)
            complete(true, contacts, nil)
        }
    }
}
