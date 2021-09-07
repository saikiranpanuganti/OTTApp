//
//  CategoriesView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/09/21.
//

import UIKit


protocol CategoriesViewDelegate: AnyObject {
    func closeTapped()
    func homeCategoryTapped(homeType: String)
    func movieSubCategoryTapped(subCategory: String)
    func tvShowsSubCategoryTapped(subCategory: String)
}


class CategoriesView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonImage: UIImageView!
    
    weak var delegate: CategoriesViewDelegate?
    
    var categoriesData: CategoryModel?
    var homeCategoriesData: [String] = []
    var category: Category = .home
    var categoryTitle: String = ""
    
    func setUpUI() {
        tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelTableViewCell")
        
        if category == .home {
            tableView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 120, right: 0)
        }else {
            tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 120, right: 0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        buttonView.layer.cornerRadius = 25
        buttonImage.image = Images.shared.close?.withRenderingMode(.alwaysTemplate)
        buttonImage.tintColor = Colors.shared.whiteColor
        
        addBlurEffect()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        self.insertSubview(blurView, at: 0)
    }
    
    
    @IBAction func closeTapped(_ sender: UIButton) {
        delegate?.closeTapped()
    }
}

extension CategoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if category == .home {
            return homeCategoriesData.count
        }else {
            return categoriesData?.body?.count ?? 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as? LabelTableViewCell {
            if category == .home {
                if indexPath.row == 0 {
                    cell.configureUI(text: homeCategoriesData[indexPath.row], isHeader: true)
                }else {
                    cell.configureUI(text: homeCategoriesData[indexPath.row], isHeader: false)
                }
            }else {
                if categoryTitle == categoriesData?.body?[indexPath.row] {
                    cell.configureUI(text: categoriesData?.body?[indexPath.row] ?? "", isHeader: true)
                }else {
                    cell.configureUI(text: categoriesData?.body?[indexPath.row] ?? "", isHeader: false)
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension CategoriesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if category == .home {
            delegate?.homeCategoryTapped(homeType: homeCategoriesData[indexPath.row])
        }else if category == .movies {
            delegate?.movieSubCategoryTapped(subCategory: categoriesData?.body?[indexPath.row] ?? "")
        }else if category == .tvShows {
            delegate?.tvShowsSubCategoryTapped(subCategory: categoriesData?.body?[indexPath.row] ?? "")
        }
        delegate?.closeTapped()
    }
}
