//
//  CryptoListContract.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation
import UIKit

// contract for viper pattern

protocol CryptoListViewProtocol: AnyObject{
    
    var presenter : CryptoList.Presenter! { get set }
    
    func updateCollectionItems(_ items: [CryptoListItem])
}

protocol CryptoListPresenterProtocol: AnyObject{
    
    var view : CryptoList.View? { get set }
    var interactor: CryptoList.Interactor! { get set }
    var router: CryptoList.Router! { get set }
    
    func viewDidLoad()
    func didUserPressItem(_ item : CryptoListItem)
    func didDataFetch()
}

protocol CryptoListInteractorProtocol: AnyObject{
    
    var presenter: CryptoList.Presenter? { get set }
    var data: [CryptoListItem]? { get }
    
    func fetchData()
}

protocol CryptoListRouterProtocol: AnyObject{
    
    var presenter: CryptoList.Presenter? { get set }
    
    static func createModule() -> UIViewController?
    func openDetail()
}

// alias for protocols
struct CryptoList{
    typealias View = CryptoListViewProtocol
    typealias Presenter = CryptoListPresenterProtocol
    typealias Interactor = CryptoListInteractorProtocol
    typealias Router = CryptoListRouterProtocol
}
