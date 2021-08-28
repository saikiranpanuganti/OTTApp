//
//  HomeTabView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

class HomeTabView:UIView{
    @IBOutlet weak var menuView: MenuView!
    @IBOutlet weak var collectionView:UICollectionView!
    
    var homeData:Home?
    
    func setupUI(){
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(UINib(nibName: "MainImageViewCell", bundle: nil), forCellWithReuseIdentifier: "MainImageViewCell")
        collectionView.register(UINib(nibName: "LabelCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LabelCollectionReusableView")
       collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.shared.blackViewColor
       
    }
    
    func addGradientView() {
        menuView.createGradientLayer()
    }
    
    func updateUI(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
}

extension HomeTabView:UICollectionViewDelegate{
    
    
}

extension HomeTabView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (homeData?.body?.data?.playlists!.count ?? 0)+1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1//homeData?.body?.data?.playlists?[section].content?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if indexPath.section == 0{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainImageViewCell", for: indexPath) as? MainImageViewCell{
                cell.configUI(img: homeData?.body?.data?.banner?[0].imagery?.banner ?? "")
                return cell
            
            }
        }
        else{
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell{
            cell.updateUI(data: homeData?.body?.data?.playlists?[indexPath.section-1])
            return cell
        }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section > 0 {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LabelCollectionReusableView", for: indexPath) as? LabelCollectionReusableView{
            
            header.configUI(title: homeData?.body?.data?.playlists?[indexPath.section-1].title ?? "")
            return header
        }
        }
        return UICollectionReusableView()
    }
    
}

extension HomeTabView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: screenWidth, height: screenHeight/1.3)
        }else{
            return CGSize(width: screenWidth, height: screenWidth/2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
           return CGSize(width: 0, height: 0)
        }
        else{
            
            return CGSize(width: screenWidth, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
