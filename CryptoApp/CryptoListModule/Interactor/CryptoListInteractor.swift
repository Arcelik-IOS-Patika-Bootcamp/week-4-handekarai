//
//  CryptoListInteractor.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation

class CryptoListInteractor: CryptoList.Interactor{
    
    private let cryptoApiEndpointURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"
    
    var presenter: CryptoList.Presenter?
    var data: [CryptoListItem]?
    
    func fetchData() {
        if let url = URL.init(string: cryptoApiEndpointURL){
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
              
              do {
                guard let data = data else {
                  return
                }
                
                let object = try JSONDecoder().decode([CryptoListItem].self, from: data)
                
                  self?.data = object
                  DispatchQueue.main.async {
                      self?.presenter?.didDataFetch()
                  }
                  
              } catch {
                print(error)
              }
            }
            
            task.resume()
          }
    }
}
