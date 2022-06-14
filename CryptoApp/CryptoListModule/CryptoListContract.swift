//
//  CryptoListContract.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation

protocol CryptoListViewProtocol: AnyObject{
    
    var presenter : CryptoList.Presenter! { get set }
    
    func updateCollectionItems(_ items: [CryptoListItem])
}

protocol CryptoListPresenterProtocol: AnyObject{
    
    var view : CryptoList.View? { get set }
    var interactor: CryptoList.Interactor! { get set }
//    var router: CryptoList.Router! { get set }
    
    func viewDidLoad()
    func didUserPressItem()
    func didDataFetch()
}

protocol CryptoListInteractorProtocol: AnyObject{
    
    var presenter: CryptoList.Presenter? { get set }
    var data: [CryptoListItem]? { get }
    
    func fetchData()

}

//protocol CryptoListEntitiyProtocol: AnyObject{ }
//
//protocol CryptoListRouterProtocol: AnyObject{
//
//    var presenter: CryptoList.Presenter? { get set }
//}

struct CryptoList{
    typealias View = CryptoListViewProtocol
    typealias Presenter = CryptoListPresenterProtocol
    typealias Interactor = CryptoListInteractorProtocol
//    typealias Entitiy = CryptoListEntitiyProtocol
//    typealias Router = CryptoListRouterProtocol
}
