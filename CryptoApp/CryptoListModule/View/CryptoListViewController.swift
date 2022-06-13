//
//  ViewController.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/12/22.
//

import UIKit
import Kingfisher


class CryptoListViewController: UIViewController, CryptoListViewProtocol {
    
    var presenter: CryptoList.Presenter!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var cryotos = [CryptoListItem]()
    private var cryptoModel = CryptoListModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fecthData()
    }

    private func setupUI(){
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(.init(nibName: "CryptoInfoCell", bundle: nil), forCellWithReuseIdentifier: "CryptoInfoCell")
    }
    
    private func fecthData(){
        cryptoModel.fetchData{ [weak self] data,conStatus  in
            switch conStatus{
            case .success:
                self?.cryotos = data.compactMap({
                    return CryptoListItem(id: $0.name, currency: $0.currency, symbol: $0.name, name: $0.name, logoURL: $0.logoURL, price: $0.price)
                })
                
                DispatchQueue.main.async {
                    self?.myCollectionView.reloadData()
                }
            case .error:
                print("eroor")
            }
        }
    }
    
    
    func updateCollectionItems(_ items: [CryptoListItem]) {
        cryotos = items
        myCollectionView?.reloadData()
    }
    
    
}

extension CryptoListViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cryotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let crypto = cryotos[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CryptoInfoCell", for: indexPath) as? CryptoInfoCell{
            print(crypto.logoURL)
            cell.imageView.kf.setImage(with: URL(string: crypto.logoURL))
            cell.nameLabel.text = crypto.name
            cell.priceLabel.text = crypto.price
            cell.currencyLabel.text = crypto.currency
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
}


extension CryptoListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height: CGFloat = 120.0
        
        return CGSize(width: width, height: height)
    }
    
}

extension CryptoListViewController: CryptoListModelDelegate{
    func didDataFetch(_ items: [CryptoListItem]) {
        print("here")
        cryotos = items
        DispatchQueue.main.async {
            self.myCollectionView?.reloadData()
        }
    }
}
