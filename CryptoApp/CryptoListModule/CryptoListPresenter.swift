//
//  CryptoListPresenter.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation

class CryptoListPresenter: CryptoList.Presenter{
    
    var view: CryptoList.View?
    var interactor: CryptoList.Interactor!
//    var router: CryptoList.Router!
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func didUserPressItem() {
        //
    }
    
    func didDataFetch() {
        guard let data = interactor.data else {return}

                let cryptos = data.compactMap({
                    return CryptoListItem(name: $0.name, image: $0.image,currentPrice: $0.currentPrice,lastUpdated: $0.lastUpdated)                })

        view?.updateCollectionItems(cryptos)
    }
    
    
}
