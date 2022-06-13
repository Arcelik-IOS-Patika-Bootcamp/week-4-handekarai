//
//  CryptoListModel.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation


class CryptoListModel{
    
    private let cryptoApiEndpointURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"
    
    func fetchData(completion: @escaping (([CryptoListItem],ConnectionStatus) -> ())){
        if let url = URL.init(string: cryptoApiEndpointURL){
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
              
              do {
                guard let data = data else {
                  return
                }
                
                let object = try JSONDecoder().decode([CryptoListItem].self, from: data)
                
                  DispatchQueue.main.async {
                      completion(object,.success)
                  }
              } catch {
                print(error)
              }
            }
            
            task.resume()
          }
        }
    }

enum ConnectionStatus{
    case success
    case error
}

