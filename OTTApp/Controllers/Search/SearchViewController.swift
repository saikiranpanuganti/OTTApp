//
//  SearchViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 21/09/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet var stackWidth: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        let placeholderColor = UIColor.lightGray
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
        searchView.layer.cornerRadius = 10.0
        searchTextField.delegate = self
        cancelButton.isHidden = true
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        cancelButton.isHidden = true
        stackWidth.isActive = false
        stackWidth.constant = 100
        stackWidth.isActive = true
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        searchTextField.resignFirstResponder()
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchQuery = textField.text?.replacingOccurrences(of: " ", with: "") {
            if searchQuery.count > 2 {
                viewModel.getSearchData(queryString: searchQuery)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        cancelButton.isHidden = false
        stackWidth.isActive = false
        stackWidth.constant = UIScreen.main.bounds.width - 95
        stackWidth.isActive = true
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
