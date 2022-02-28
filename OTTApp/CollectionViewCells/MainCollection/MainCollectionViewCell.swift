//
//  MainCollectionViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

protocol MainCollectionViewCellDelegate: AnyObject {
    func videoTapped(video: Video?)
}

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView:UICollectionView!
    
    weak var delegate: MainCollectionViewCellDelegate?
    var playListData:Playlist?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
       collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.shared.blackViewColor
    }
    
    func updateUI(data:Playlist?){
        playListData = data
        collectionView.reloadData()
    }
    
}

extension MainCollectionViewCell:UICollectionViewDelegate{
    
    
}

extension MainCollectionViewCell:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playListData?.content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell{
            
            cell.configUI(urlString: (playListData?.content?[indexPath.row].imagery?.thumbnail ?? "") + "?d=200x200")
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension MainCollectionViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/2.8, height: screenWidth/2.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.videoTapped(video: playListData?.content?[indexPath.row])
    }
}
