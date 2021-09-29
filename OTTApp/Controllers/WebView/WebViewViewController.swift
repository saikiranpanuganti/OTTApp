//
//  WebViewViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 29/09/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    @IBOutlet weak var webKit: WKWebView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarHeight.constant = topSafeArea + 40
        
        guard let url = URL(string: "https://help.netflix.com/legal/privacy") else { return }
        let request = URLRequest(url: url)
        webKit.load(request)
    }

    @IBAction func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
