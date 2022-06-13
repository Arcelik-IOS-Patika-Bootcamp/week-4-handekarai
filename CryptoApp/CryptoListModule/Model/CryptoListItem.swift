//
//  CrytoListItem.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/12/22.
//

import Foundation

struct CryptoListItem: Codable {
    var id, currency, symbol, name: String
    var logoURL: String
    var price: String

    enum CodingKeys: String, CodingKey {
        case id, currency, symbol, name
        case logoURL = "logo_url"
        case price
    }
}

enum Status: String, Codable {
    case active = "active"
}
