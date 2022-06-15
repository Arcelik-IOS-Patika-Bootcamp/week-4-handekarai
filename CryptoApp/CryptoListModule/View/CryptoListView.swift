//
//  ViewController.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/12/22.
//

import UIKit
import Kingfisher

class CryptoListView: UIViewController, CryptoList.View {
        
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var cryptosList = [CryptoListItem]()
    let refreshControl = UIRefreshControl()
    var presenter: CryptoList.Presenter!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    // after scroll down triggered , this func runs to refresh list
    @objc private func refreshData(_ sender: Any) {
        presenter.viewDidLoad()
        refreshControl.endRefreshing()
    }

    private func setupUI(){
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(.init(nibName: "CryptoInfoCell", bundle: nil), forCellWithReuseIdentifier: "CryptoInfoCell")
        
        // settings for scroll down refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        myCollectionView.addSubview(refreshControl)
    }
    
}

extension CryptoListView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cryptosList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let crypto = cryptosList[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CryptoInfoCell", for: indexPath) as? CryptoInfoCell{
            
            // cell fields settings
            cell.imageView.kf.setImage(with: URL(string: crypto.image))
            cell.nameLabel.text = crypto.name
            cell.priceLabel.text = "$\(crypto.currentPrice)"
            cell.lastUpdatedLabel.text = crypto.lastUpdated
            cell.priceChangePercentage.text = "%\(crypto.priceChangePercentage24H)"
            cell.priceChangePercentage.textColor = crypto.priceChangePercentage24H > 0 ? .systemGreen : .systemRed
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let crypto = cryptosList[indexPath.row]
        presenter.didUserPressItem(crypto)
    }
}


extension CryptoListView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height: CGFloat = 120.0
        
        return CGSize(width: width, height: height)
    }
}

//MARK: - Presenter Related
extension CryptoListView{
    func updateCollectionItems(_ items: [CryptoListItem]) {
        cryptosList = items
        myCollectionView?.reloadData()
    }
}
