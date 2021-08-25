//
//  HomeTabView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

class HomeTabView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var homeData: Home?
    
    func setUpUI() {
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(UINib(nibName: "LabelCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LabelCollectionReusableView")
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeTabView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (homeData?.body?.data?.playlists?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
                cell.configureUI(urlString: homeData?.body?.data?.banner?[0].imagery?.banner ?? "")
                return cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell {
                cell.updateUI(data: homeData?.body?.data?.playlists?[indexPath.section - 1])
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section > 0 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LabelCollectionReusableView", for: indexPath) as? LabelCollectionReusableView {
                header.configureUI(headerTitle: homeData?.body?.data?.playlists?[indexPath.section - 1].title ?? "")
                return header
            }
        }
        
        return UICollectionReusableView()
    }
}

extension HomeTabView: UICollectionViewDelegate {
    
}

extension HomeTabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section > 0 {
            return CGSize(width: screenWidth, height: 50)
        }
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: screenWidth, height: screenWidth*1.2)
        }else {
            return CGSize(width: screenWidth, height: screenWidth/2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

