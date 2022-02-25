//
//  UsersView.swift
//  OTTApp
//
//  Created by pampana ajay on 27/08/21.
//

import UIKit


protocol UsersViewDelegate: AnyObject {
    func profileTapped()
    func addProfile()
}

class UsersView:UIView{
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: UsersViewDelegate?
    
    var profiles = User.shared.savedUser?.profiles ?? []
    var isEditOn: Bool = false
    
    func setupUI() {
        collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension UsersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if profiles.count < 5 {
            return profiles.count + 1
        }else {
            return profiles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell {
            if indexPath.row < profiles.count {
                cell.configureUI(profile: profiles[indexPath.row], editOn: isEditOn)
            }else {
                cell.configureUI(systemImage: "plus.circle")
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension UsersView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < profiles.count {
            User.shared.selectedProfile = profiles[indexPath.row]
            delegate?.profileTapped()
        }else {
            delegate?.addProfile()
        }
    }
}

extension UsersView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
