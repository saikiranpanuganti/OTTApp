//
//  NewMenu.swift
//  NetflixMenu
//
//  Created by SaiKiran Panuganti on 13/06/21.
//  Copyright © 2021 Saikiran Panuganti. All rights reserved.
//

enum CurrentSection {
    case tvShow
    case movie
    case myList
    case none
}

protocol MenuViewDelegate: AnyObject {
    func logoButtonTapped()
    func tvButtonTapped()
    func tvSubButtonTapped()
    func moviesButtonTapped()
    func movieSubButtonTapped()
    func myListButtonTapped()
    func castTapped()
    func homeCategoriesTapped(category: CurrentSection)
}

import Foundation
import UIKit

class MenuView: UIView {
    weak var delegate: MenuViewDelegate?
    
    private var tvLeftAnchor = NSLayoutConstraint()
    private var moviesLeftAnchor = NSLayoutConstraint()
    private var myListLeftAnchor = NSLayoutConstraint()
    private var tvSubLeftAnchor = NSLayoutConstraint()
    private var moviesSubLeftAnchor = NSLayoutConstraint()
    
    private let ScreenWidth = UIScreen.main.bounds.width
    private var spacing : CGFloat {
        return (ScreenWidth-190)/4
    }
    private var movieSpacing : CGFloat {
        return 75 + (2*spacing)
    }
    private var myListSpacing : CGFloat {
        return 130 + (3*spacing)
    }
    private var currentSection : CurrentSection = .none
    var selectedMenu: CurrentSection = .none {
        didSet {
            setSelectedMenu(menu: selectedMenu)
        }
    }
    var movieSubTitle: String? {
        didSet {
            movieSubLabel.text = movieSubTitle ?? "All Genres"
            tvSubLabel.text = "All Genres"
        }
    }
    var tvSubTitle: String? {
        didSet {
            tvSubLabel.text = tvSubTitle ?? "All Genres"
            movieSubLabel.text = "All Genres"
        }
    }
    
    lazy private var logoView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
                
        return view
    }()
    
    lazy private var logoImageView : UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = Images.shared.netflixLogo
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        return logoImage
    }()
    
    lazy private var logoButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(logoButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy private var tvView : UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy private var tvLabel : UILabel = {
        let label = UILabel()
        label.text = "TV Shows"
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var tvArrow : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.downArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy private var tvButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tvButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy private var moviesView : UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy private var moviesLabel : UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var moviesArrow : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.downArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy private var moviesButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(moviesButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy private var myListView : UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy private var myListLabel : UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var myListArrow : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.downArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy private var myListButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(myListButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy private var tvSubView : UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var tvSubLabel : UILabel = {
        let label = UILabel()
        label.text = "All Genres"
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var tvSubArrow : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.downArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy private var tvSubButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tvSubButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy private var movieSubView : UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var movieSubLabel : UILabel = {
        let label = UILabel()
        label.text = "All Genres"
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var movieSubArrow : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.downArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy private var movieSubButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(movieSubButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy private var castView : UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var castImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.cast?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Colors.shared.whiteColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var castButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(castTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.shared.clear
        setUpUI()
        setUpConstraints()
        
        tvSubView.isHidden = true
        movieSubView.isHidden = true
        
        tvArrow.isHidden = true
        moviesArrow.isHidden = true
        myListArrow.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = Colors.shared.clear
        setUpUI()
        setUpConstraints()
        
        tvSubView.isHidden = true
        movieSubView.isHidden = true
        
        tvArrow.isHidden = true
        moviesArrow.isHidden = true
        myListArrow.isHidden = true
    }
    
    private func setUpUI() {
        self.addSubview(logoView)
        self.addSubview(logoImageView)
        self.addSubview(logoButton)
        
        self.addSubview(castView)
        castView.addSubview(castImage)
        castView.addSubview(castButton)
        
        self.addSubview(tvView)
        tvView.addSubview(tvLabel)
        tvView.addSubview(tvArrow)
        tvView.addSubview(tvButton)

        self.addSubview(moviesView)
        moviesView.addSubview(moviesLabel)
        moviesView.addSubview(moviesArrow)
        moviesView.addSubview(moviesButton)

        self.addSubview(myListView)
        myListView.addSubview(myListLabel)
        myListView.addSubview(myListArrow)
        myListView.addSubview(myListButton)

        self.addSubview(tvSubView)
        tvSubView.addSubview(tvSubLabel)
        tvSubView.addSubview(tvSubArrow)
        tvSubView.addSubview(tvSubButton)

        self.addSubview(movieSubView)
        movieSubView.addSubview(movieSubLabel)
        movieSubView.addSubview(movieSubArrow)
        movieSubView.addSubview(movieSubButton)
    }
    
    private func setUpConstraints() {
        logoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        logoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        logoImageView.widthAnchor.constraint(equalTo: logoView.widthAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: logoView.heightAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: logoView.centerXAnchor).isActive = true
        
        logoButton.widthAnchor.constraint(equalTo: logoView.widthAnchor).isActive = true
        logoButton.heightAnchor.constraint(equalTo: logoView.heightAnchor).isActive = true
        logoButton.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
        logoButton.centerXAnchor.constraint(equalTo: logoView.centerXAnchor).isActive = true
        
        castView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        castView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        castView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        castView.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
        
        castImage.widthAnchor.constraint(equalTo: castView.widthAnchor).isActive = true
        castImage.heightAnchor.constraint(equalTo: castView.heightAnchor).isActive = true
        castImage.centerYAnchor.constraint(equalTo: castView.centerYAnchor).isActive = true
        castImage.centerXAnchor.constraint(equalTo: castView.centerXAnchor).isActive = true
        
        castButton.widthAnchor.constraint(equalTo: castView.widthAnchor).isActive = true
        castButton.heightAnchor.constraint(equalTo: castView.heightAnchor).isActive = true
        castButton.centerYAnchor.constraint(equalTo: castView.centerYAnchor).isActive = true
        castButton.centerXAnchor.constraint(equalTo: castView.centerXAnchor).isActive = true
        
        tvLeftAnchor = tvView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spacing+10)
        tvLeftAnchor.isActive = true
        tvView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        tvView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 10).isActive = true
        tvView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tvLabel.leftAnchor.constraint(equalTo: tvView.leftAnchor, constant: 0).isActive = true
        tvLabel.centerYAnchor.constraint(equalTo: tvView.centerYAnchor).isActive = true
        
        tvArrow.leftAnchor.constraint(equalTo: tvLabel.rightAnchor, constant: 5).isActive = true
        tvArrow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        tvArrow.centerYAnchor.constraint(equalTo: tvLabel.centerYAnchor, constant: 1).isActive = true
        tvArrow.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        tvButton.centerYAnchor.constraint(equalTo: tvView.centerYAnchor).isActive = true
        tvButton.centerXAnchor.constraint(equalTo: tvView.centerXAnchor).isActive = true
        tvButton.widthAnchor.constraint(equalTo: tvView.widthAnchor).isActive = true
        tvButton.heightAnchor.constraint(equalTo: tvView.heightAnchor).isActive = true
        
        moviesLeftAnchor = moviesView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: movieSpacing)
        moviesLeftAnchor.isActive = true
        moviesView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        moviesView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 10).isActive = true
        moviesView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        moviesLabel.centerXAnchor.constraint(equalTo: moviesView.centerXAnchor, constant: 0).isActive = true
        moviesLabel.centerYAnchor.constraint(equalTo: moviesView.centerYAnchor).isActive = true
        
        moviesArrow.leftAnchor.constraint(equalTo: moviesLabel.rightAnchor, constant: 5).isActive = true
        moviesArrow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        moviesArrow.centerYAnchor.constraint(equalTo: moviesLabel.centerYAnchor, constant: 1).isActive = true
        moviesArrow.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        moviesButton.centerYAnchor.constraint(equalTo: moviesView.centerYAnchor).isActive = true
        moviesButton.centerXAnchor.constraint(equalTo: moviesView.centerXAnchor).isActive = true
        moviesButton.widthAnchor.constraint(equalTo: moviesView.widthAnchor).isActive = true
        moviesButton.heightAnchor.constraint(equalTo: moviesView.heightAnchor).isActive = true
        
        myListLeftAnchor = myListView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: myListSpacing-10)
        myListLeftAnchor.isActive = true
        myListView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        myListView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 10).isActive = true
        myListView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        myListLabel.leftAnchor.constraint(equalTo: myListView.leftAnchor, constant: 0).isActive = true
        myListLabel.centerYAnchor.constraint(equalTo: myListView.centerYAnchor).isActive = true
        
        myListArrow.leftAnchor.constraint(equalTo: myListLabel.rightAnchor, constant: 5).isActive = true
        myListArrow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        myListArrow.centerYAnchor.constraint(equalTo: myListLabel.centerYAnchor, constant: 1).isActive = true
        myListArrow.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        myListButton.centerYAnchor.constraint(equalTo: myListView.centerYAnchor).isActive = true
        myListButton.centerXAnchor.constraint(equalTo: myListView.centerXAnchor).isActive = true
        myListButton.widthAnchor.constraint(equalTo: myListView.widthAnchor).isActive = true
        myListButton.heightAnchor.constraint(equalTo: myListView.heightAnchor).isActive = true
        
        tvSubLeftAnchor = tvSubView.leftAnchor.constraint(equalTo: tvView.rightAnchor, constant: -10)
        tvSubLeftAnchor.isActive = true
//        tvSubView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        tvSubView.centerYAnchor.constraint(equalTo: tvArrow.centerYAnchor, constant: 0).isActive = true
        tvSubView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tvSubLabel.leftAnchor.constraint(equalTo: tvSubView.leftAnchor, constant: 0).isActive = true
        tvSubLabel.centerYAnchor.constraint(equalTo: tvSubView.centerYAnchor).isActive = true
        
        tvSubArrow.leftAnchor.constraint(equalTo: tvSubLabel.rightAnchor, constant: 5).isActive = true
        tvSubArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        tvSubArrow.centerYAnchor.constraint(equalTo: tvSubLabel.centerYAnchor, constant: 1).isActive = true
        tvSubArrow.heightAnchor.constraint(equalToConstant: 10).isActive = true
        tvSubArrow.rightAnchor.constraint(equalTo: tvSubView.rightAnchor, constant: 0).isActive = true
        
        tvSubButton.centerYAnchor.constraint(equalTo: tvSubView.centerYAnchor).isActive = true
        tvSubButton.centerXAnchor.constraint(equalTo: tvSubView.centerXAnchor).isActive = true
        tvSubButton.widthAnchor.constraint(equalTo: tvSubView.widthAnchor).isActive = true
        tvSubButton.heightAnchor.constraint(equalTo: tvSubView.heightAnchor).isActive = true
        
        moviesSubLeftAnchor = movieSubView.leftAnchor.constraint(equalTo: moviesView.rightAnchor, constant: -10)
        moviesSubLeftAnchor.isActive = true
//        movieSubView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        movieSubView.centerYAnchor.constraint(equalTo: moviesArrow.centerYAnchor, constant: 0).isActive = true
        movieSubView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        movieSubLabel.leftAnchor.constraint(equalTo: movieSubView.leftAnchor, constant: 0).isActive = true
        movieSubLabel.centerYAnchor.constraint(equalTo: movieSubView.centerYAnchor).isActive = true
        
        movieSubArrow.leftAnchor.constraint(equalTo: movieSubLabel.rightAnchor, constant: 5).isActive = true
        movieSubArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        movieSubArrow.centerYAnchor.constraint(equalTo: movieSubLabel.centerYAnchor, constant: 1).isActive = true
        movieSubArrow.heightAnchor.constraint(equalToConstant: 10).isActive = true
        movieSubArrow.rightAnchor.constraint(equalTo: movieSubView.rightAnchor, constant: 0).isActive = true
        
        movieSubButton.centerYAnchor.constraint(equalTo: movieSubView.centerYAnchor).isActive = true
        movieSubButton.centerXAnchor.constraint(equalTo: movieSubView.centerXAnchor).isActive = true
        movieSubButton.widthAnchor.constraint(equalTo: movieSubView.widthAnchor).isActive = true
        movieSubButton.heightAnchor.constraint(equalTo: movieSubView.heightAnchor).isActive = true
    }
    
    func createGradientLayer() {
        if layer.sublayers?.first?.isKind(of: CAGradientLayer.self) ?? false {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [Colors.shared.menuTopGradientColor.cgColor, Colors.shared.menuBottomGradientColor.cgColor,Colors.shared.clear.cgColor]
        gradient.locations = [0.0, 0.6, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func getMovieSubCategoryTitle() -> String? {
        return movieSubLabel.text == "All Genres" ? "All Categories" : movieSubLabel.text
    }
    func getTvShowsSubCategoryTitle() -> String? {
        return tvSubLabel.text == "All Genres" ? "All Categories" : tvSubLabel.text
    }
    
    private func setSelectedMenu(menu: CurrentSection) {
        if menu == .movie {
            if currentSection != .movie {
                print("Select Movie")
                movieSelected()
            }
        }else if menu == .tvShow {
            if currentSection != .tvShow {
                print("Select TV Shows")
                tvShowSelecetd()
            }
        }else if menu == .myList {
            if currentSection != .myList {
                print("Select My List")
                myListSelecetd()
            }
        }else {
            if currentSection != .none {
                print("Select Home")
                logoTapped()
            }
        }
    }
    
    private func setTvShowsSpacing() {
        tvLeftAnchor.isActive = false
        tvLeftAnchor.constant = spacing
        tvLeftAnchor.isActive = true
    }
    private func setMoviesSpacing() {
        moviesLeftAnchor.isActive = false
        moviesLeftAnchor.constant = movieSpacing
        moviesLeftAnchor.isActive = true
    }
    private func setMyListSpacing() {
        myListLeftAnchor.isActive = false
        myListLeftAnchor.constant = myListSpacing
        myListLeftAnchor.isActive = true
    }
    
    private func tvShowSelecetd() {
        if currentSection == .movie {
            setMoviesSpacing()
            setMyListSpacing()
            
            moviesArrow.isHidden = true
            movieSubView.isHidden = true
            
            hideUnhideViews(hideTv: false, hideMovie: true, hideMyList: true)
            
            tvSubView.isHidden = false
            
            tvLeftAnchor.isActive = false
            tvSubLeftAnchor.isActive = false
            tvLeftAnchor.constant = 30
            tvSubLeftAnchor.constant = 40
            tvLeftAnchor.isActive = true
            tvSubLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
                self.tvLabel.font = UIFont.systemFont(ofSize: 20)
            }) { (bool) in
                self.tvArrow.isHidden = false
                self.currentSection = .tvShow
            }
        }else if currentSection == .myList {
            setMoviesSpacing()
            setTvShowsSpacing()
            
            moviesArrow.isHidden = true
            movieSubView.isHidden = true
            
            hideUnhideViews(hideTv: false, hideMovie: true, hideMyList: true)
            
            tvSubView.isHidden = false
            
            tvLeftAnchor.isActive = false
            tvSubLeftAnchor.isActive = false
            tvLeftAnchor.constant = 30
            tvSubLeftAnchor.constant = 40
            tvLeftAnchor.isActive = true
            tvSubLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
                self.tvLabel.font = UIFont.systemFont(ofSize: 20)
            }) { (bool) in
                self.tvArrow.isHidden = false
                self.currentSection = .tvShow
            }
        }else if currentSection == .none {
            
        }
    }
    
    private func movieSelected() {
        if currentSection == .tvShow {
            setTvShowsSpacing()
            setMyListSpacing()
            
            tvArrow.isHidden = true
            tvSubView.isHidden = true
            
            hideUnhideViews(hideTv: true, hideMovie: false, hideMyList: true)
            
            movieSubView.isHidden = false
            
            moviesLeftAnchor.isActive = false
            moviesSubLeftAnchor.isActive = false
            moviesLeftAnchor.constant = 30
            moviesSubLeftAnchor.constant = 40
            moviesLeftAnchor.isActive = true
            moviesSubLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            }) { (bool) in
                self.moviesArrow.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.moviesLabel.font = UIFont.systemFont(ofSize: 20)
                }
                self.currentSection = .movie
            }
        }else if currentSection == .myList {
            setTvShowsSpacing()
            setMyListSpacing()
            
            tvArrow.isHidden = true
            tvSubView.isHidden = true
            
            hideUnhideViews(hideTv: true, hideMovie: false, hideMyList: true)
            
            movieSubView.isHidden = false
            
            moviesLeftAnchor.isActive = false
            moviesSubLeftAnchor.isActive = false
            moviesLeftAnchor.constant = 30
            moviesSubLeftAnchor.constant = 40
            moviesLeftAnchor.isActive = true
            moviesSubLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            }) { (bool) in
                self.moviesArrow.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.moviesLabel.font = UIFont.systemFont(ofSize: 20)
                }
                self.currentSection = .movie
            }
        }else if currentSection == .none {
            
        }
    }
    
    private func myListSelecetd() {
        if currentSection == .movie {
            setTvShowsSpacing()
            setMoviesSpacing()
            
            myListArrow.isHidden = true
            
            hideUnhideViews(hideTv: true, hideMovie: true, hideMyList: false)
            
            tvSubView.isHidden = true
            movieSubView.isHidden = true
            
            myListLeftAnchor.isActive = false
            myListLeftAnchor.constant = 30
            myListLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            }) { (bool) in
                self.myListArrow.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.myListLabel.font = UIFont.systemFont(ofSize: 18)
                }
                self.currentSection = .myList
            }
        }else if currentSection == .tvShow {
            setTvShowsSpacing()
            setMoviesSpacing()
            
            myListArrow.isHidden = true
            
            hideUnhideViews(hideTv: true, hideMovie: true, hideMyList: false)
            
            tvSubView.isHidden = true
            movieSubView.isHidden = true
            
            myListLeftAnchor.isActive = false
            myListLeftAnchor.constant = 30
            myListLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            }) { (bool) in
                self.myListArrow.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.myListLabel.font = UIFont.systemFont(ofSize: 18)
                }
                self.currentSection = .myList
            }
        }else if currentSection == .myList {
            
        }else if currentSection == .none {
            
        }
    }
    
    private func unhideViews() {
        self.tvView.isHidden = false
        self.myListView.isHidden = false
        self.moviesView.isHidden = false
    }
    
    private func hideUnhideViews(hideTv: Bool, hideMovie: Bool, hideMyList: Bool) {
        self.tvView.isHidden = hideTv
        self.myListView.isHidden = hideMyList
        self.moviesView.isHidden = hideMovie
        
        setFontToViews()
    }
    
    private func hideSubViews() {
        moviesArrow.isHidden = true
        movieSubView.isHidden = true
        
        myListArrow.isHidden = true
        
        tvArrow.isHidden = true
        tvSubView.isHidden = true
    }
    
    private func setFontToViews() {
        self.myListLabel.font = UIFont.systemFont(ofSize: 16)
        self.moviesLabel.font = UIFont.systemFont(ofSize: 16)
        self.tvLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setUpViewAnchors() {
        self.tvSubLeftAnchor.isActive = false
        self.tvSubLeftAnchor.constant = -10
        self.tvSubLeftAnchor.isActive = true
        
        self.moviesSubLeftAnchor.isActive = false
        self.moviesSubLeftAnchor.constant = -10
        self.moviesSubLeftAnchor.isActive = true
        
        setMoviesSpacing()
        setMyListSpacing()
        setTvShowsSpacing()
    }
    
    private func logoTapped() {
        hideUnhideViews(hideTv: false, hideMovie: false, hideMyList: false)
        hideSubViews()
        setFontToViews()
        setUpViewAnchors()
        
        currentSection = .none
        tvSubLabel.text = "All Genres"
        movieSubLabel.text = "All Genres"
    }
    
    @objc private func tvButtonTapped(_ sender : UIButton) {
        if currentSection != .tvShow {
            delegate?.tvButtonTapped()
            
            hideUnhideViews(hideTv: false, hideMovie: true, hideMyList: true)
            
            tvSubView.isHidden = false
            
            tvLeftAnchor.isActive = false
            tvSubLeftAnchor.isActive = false
            tvLeftAnchor.constant = 30
            tvSubLeftAnchor.constant = 40
            tvLeftAnchor.isActive = true
            tvSubLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
                self.tvLabel.font = UIFont.systemFont(ofSize: 20)
            }) { (bool) in
                self.tvArrow.isHidden = false
                self.currentSection = .tvShow
            }
        }else {
            delegate?.homeCategoriesTapped(category: .tvShow)
        }
    }
    
    @objc private func moviesButtonTapped(_ sender : UIButton) {
        if currentSection != .movie {
            delegate?.moviesButtonTapped()
            
            hideUnhideViews(hideTv: true, hideMovie: false, hideMyList: true)
            
            movieSubView.isHidden = false
            
            moviesLeftAnchor.isActive = false
            moviesSubLeftAnchor.isActive = false
            moviesLeftAnchor.constant = 30
            moviesSubLeftAnchor.constant = 40
            moviesLeftAnchor.isActive = true
            moviesSubLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            }) { (bool) in
                self.moviesArrow.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.moviesLabel.font = UIFont.systemFont(ofSize: 20)
                }
                self.currentSection = .movie
            }
        }else {
            delegate?.homeCategoriesTapped(category: .movie)
        }
    }
    
    @objc private func myListButtonTapped(_ sender : UIButton) {
        if currentSection != .myList {
            delegate?.myListButtonTapped()
            
            hideUnhideViews(hideTv: true, hideMovie: true, hideMyList: false)
            
            myListLeftAnchor.isActive = false
            myListLeftAnchor.constant = 30
            myListLeftAnchor.isActive = true
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            }) { (bool) in
                self.myListArrow.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.myListLabel.font = UIFont.systemFont(ofSize: 18)
                }
                self.currentSection = .myList
            }
        }else {
            delegate?.homeCategoriesTapped(category: .myList)
        }
    }
    
    @objc private func logoButtonTapped(_ sender : UIButton) {
        delegate?.logoButtonTapped()
        logoTapped()
    }
    
    @objc private func tvSubButtonTapped(_ sender : UIButton) {
        delegate?.tvSubButtonTapped()
    }
    
    @objc private func movieSubButtonTapped(_ sender : UIButton) {
        delegate?.movieSubButtonTapped()
    }
    
    @objc private func castTapped(_ sender: UIButton) {
        delegate?.castTapped()
    }
}
