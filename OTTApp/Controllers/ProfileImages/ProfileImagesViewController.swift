//
//  ProfileImagesViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/02/22.
//

import UIKit

protocol ProfileImagesViewControllerDelegate: AnyObject {
    func selectedImage(image: String)
}

class ProfileImagesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ProfileImagesViewControllerDelegate?
    var images: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getImages()
        
    }

    func getImages() {
        for i in 1...56 {
            images.append("profile"+String(i))
        }
        collectionView.reloadData()
    }
    
}

extension ProfileImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            cell.configureUI(image: images[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ProfileImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedImage(image: images[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-24)/4, height: (collectionView.frame.width-24)/4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
