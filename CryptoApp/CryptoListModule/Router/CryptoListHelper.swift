//
//  CryptoListHelper.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/14/22.
//

import UIKit

extension CryptoList{
    
    static func createModule() -> UIViewController?{
        if let view = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CryptoListView") as? CryptoListView{
            let presenter = CryptoListPresenter()
            let interactor = CryptoListInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            interactor.presenter = presenter
            return view
        }
        return nil
    }
}
