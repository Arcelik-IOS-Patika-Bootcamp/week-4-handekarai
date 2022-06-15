//
//  CryptoListRouter.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/13/22.
//

import Foundation
import UIKit

class CryptoListRouter : CryptoList.Router{
    
    weak var presenter: CryptoList.Presenter?
    
    // connects layers of viper pattern
    static func createModule() -> UIViewController?{
        if let view = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CryptoListView") as? CryptoListView{
            let presenter = CryptoListPresenter()
            let interactor = CryptoListInteractor()
            let router = CryptoListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            router.presenter = presenter
            return view
        }
        return nil
    }
    
    func openDetail() {
        // MARK: future work
        // opens details of crypto coin
    }
}
