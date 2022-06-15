//
//  CryptoListPresenter.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation

class CryptoListPresenter: CryptoList.Presenter{
    
    weak var view: CryptoList.View?
    var interactor: CryptoList.Interactor!
    var router: CryptoList.Router!
    
    // fetchs data from interactor layer
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func didUserPressItem(_ item: CryptoListItem) {
        // MARK: - future work
        // router.openDetail()
        // routes to open new detail page
    }
    
    // maps data that comes from interactor layer
    func didDataFetch() {
        guard let data = interactor.data else {return}

                let cryptos = data.compactMap({
                    return CryptoListItem(name: $0.name, image: $0.image,currentPrice: $0.currentPrice,lastUpdated: getDateFormated($0.lastUpdated), priceChangePercentage24H: $0.priceChangePercentage24H,marketCap: $0.marketCap,marketCapRank: $0.marketCapRank,totalVolume: $0.totalVolume)                })

        view?.updateCollectionItems(cryptos)
    }
    
    // changes ISO8601 with fractional date format to 'dd-MM-yyyy HH:mm'
    private func getDateFormated(_ date:String) -> String{
        let dateFormatter =  ISO8601DateFormatter()
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
        let date = dateFormatter.date(from: date) ?? Date()
        let outDateFormatter: DateFormatter = {
             let df = DateFormatter()
             df.dateFormat = "dd-MM-yyyy HH:mm"
             df.locale = Locale(identifier: "en_US_POSIX")
             return df
         }()
        let formattedString = outDateFormatter.string(from: date)
        return "\(formattedString)"
    }
    
    
}
