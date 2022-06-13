//
//  CryptoListModel.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation

protocol CryptoListModelDelegate: AnyObject{
    
    func didDataFetch(_ items: [CryptoListItem])
}

class CryptoListModel{
    
    private let apiKey = "f55d9e79dbd8f1cc8c2452d627dcbca1be4e28d1"
    private let cryptoApiEndpointURL = "https://api.nomics.com/v1/"
    
    weak var delegate: CryptoListModelDelegate?
    

    
    func fetchData(completion: @escaping (([CryptoListItem],ConnectionStatus) -> ())){
        if let url = URL.init(string: cryptoApiEndpointURL + "currencies/ticker?key=" + apiKey){
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

