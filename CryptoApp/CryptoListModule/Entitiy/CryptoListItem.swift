//
//  CryptoListEntitiy.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation

// Json Fields for Crypto Coin
struct CryptoListItem: Codable {
    var name: String
    var image: String
    var currentPrice: Double
    var lastUpdated: String
    var priceChangePercentage24H: Double
    var marketCap, marketCapRank: Int
    var totalVolume: Double

    enum CodingKeys: String, CodingKey {
        case  name, image
        case currentPrice = "current_price"
        case lastUpdated = "last_updated"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"

    }
}
