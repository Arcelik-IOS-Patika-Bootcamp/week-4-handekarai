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
    let refreshControl = UIRefreshControl()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fecthData()
    }
    
    @objc private func refreshData(_ sender: Any) {
        fecthData()
        self.refreshControl.endRefreshing()
    }

    private func setupUI(){
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(.init(nibName: "CryptoInfoCell", bundle: nil), forCellWithReuseIdentifier: "CryptoInfoCell")
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
           myCollectionView.addSubview(refreshControl) 
    }
    
    private func fecthData(){
        cryptoModel.fetchData{ [weak self] data,conStatus  in
            switch conStatus{
            case .success:
                self?.cryotos = data.compactMap({
                    return CryptoListItem(name: $0.name, image: $0.image,currentPrice: $0.currentPrice,lastUpdated: $0.lastUpdated)                })
                
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
            cell.imageView.kf.setImage(with: URL(string: crypto.image))
            cell.nameLabel.text = crypto.name
            cell.priceLabel.text = "$\(crypto.currentPrice)"
            cell.currencyLabel.text = getDateFormated(crypto.lastUpdated)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
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


extension CryptoListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height: CGFloat = 120.0
        
        return CGSize(width: width, height: height)
    }
    
}

