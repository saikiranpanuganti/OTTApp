//
//  BaseViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/03/22.
//

import UIKit

class BaseViewController: UIViewController {
    var loader: Loader = Loader(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.frame = self.view.frame
    }

    func showLoader() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            
            if (window.subviews.contains(self.loader)) {
                window.bringSubviewToFront(self.loader)
            }else{
                window.addSubview(self.loader)
                window.bringSubviewToFront(self.loader)
            }
            self.loader.startAnimation()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.loader.removeFromSuperview()
        }
    }
}
