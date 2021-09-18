//
//  MoreLikeThisTableViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 17/09/21.
//

import UIKit

class MoreLikeThisTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var moreLikeThisData: MoreLikeThisModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureUI(data: MoreLikeThisModel?) {
        if let data = data {
            moreLikeThisData = data
            collectionView.reloadData()
        }
    }
}

extension MoreLikeThisTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreLikeThisData?.response?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            cell.configUI(urlString: moreLikeThisData?.response?[indexPath.row].imagery?.thumbnail ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MoreLikeThisTableViewCell: UICollectionViewDelegate {
    
}

extension MoreLikeThisTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenWidth-8)/3, height: (screenWidth-8)/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
