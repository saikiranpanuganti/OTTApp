//
//  Loader.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/03/22.
//

import UIKit

enum LoaderType: String {
    case dualballs = "dualBalls-"
    case dualRings = "dualRings-"
    case ring = "ring-"
    case infinity = "infinity-"
}

class Loader: UIView {
    
    var loaderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var loaderType: LoaderType = LoaderType.dualRings
    var index: Int = 1
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loaderImage)
        
        loaderImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loaderImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loaderImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loaderImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func startAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    @objc private func changeImage() {
        if index > 30 {
            self.index = 1
        }
        let img = self.loaderType.rawValue + String(self.index)
        self.loaderImage.image = UIImage(named: img)
        self.index += 1
    }
    
    func stopAnimating() {
        timer?.invalidate()
        timer = nil
        index = 1
    }
    
}
