//
//  HomeTabView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

protocol HomeTabViewDelegate: AnyObject {
    func movieSubButtonTapped()
    func tvSubButtonTapped()
    func homeCategoriesTapped()
    func tvButtonTapped()
    func moviesButtonTapped()
    func logoButtonTapped()
    func videoTapped(video: Video?)
}

class HomeTabView:UIView{
    @IBOutlet weak var menuView: MenuView!
    @IBOutlet weak var collectionView:UICollectionView!
    
    weak var delegate: HomeTabViewDelegate?
    var homeData:Home?
    var tvShowsData:Home?
    var moviesData:Home?
    var category: Category = .home
    var subCategoryData: SubCategory?
    
    func setupUI(){
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(UINib(nibName: "MainImageViewCell", bundle: nil), forCellWithReuseIdentifier: "MainImageViewCell")
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(UINib(nibName: "LabelCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LabelCollectionReusableView")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.shared.blackViewColor
        menuView.delegate = self
    }
    
    func addGradientView() {
        menuView.createGradientLayer()
    }
    
    func updateUI(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func updateMenuView(selectedItem: String) {
        if selectedItem == "Home" {
            menuView.selectedMenu = .none
        }else if selectedItem == "TV Shows" {
            menuView.selectedMenu = .tvShow
        }else if selectedItem == "My List" {
            menuView.selectedMenu = .myList
        }else if selectedItem == "Movies" {
            menuView.selectedMenu = .movie
        }
    }
    
    func getMovieSubCategoryTitle() -> String? {
        return menuView.getMovieSubCategoryTitle()
    }
    
    func getTvShowsSubCategoryTitle() -> String? {
        return menuView.getTvShowsSubCategoryTitle()
    }
    
    func setMovieSubCategoryTitle(title: String) {
        menuView.movieSubTitle = title
    }
    
    func setTvShowsSubCategoryTitle(title: String) {
        menuView.tvSubTitle = title
    }
}

extension HomeTabView:UICollectionViewDelegate{
    
    
}

extension HomeTabView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if category == .home {
            return (homeData?.body?.data?.playlists?.count ?? 0)+1
        }else if category == .movies {
            return (moviesData?.body?.data?.playlists?.count ?? 0)+1
        }else if category == .tvShows {
            return (tvShowsData?.body?.data?.playlists?.count ?? 0)+1
        }else if category == .subCategory {
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if category == .subCategory {
            if section == 0 {
                return 1
            }else {
                return subCategoryData?.body?.data?.playlists?.count ?? 0
            }
        }
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if indexPath.section == 0{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainImageViewCell", for: indexPath) as? MainImageViewCell{
                if category == .home {
                    cell.configUI(img: homeData?.body?.data?.banner?[0].imagery?.banner ?? "")
                }else if category == .movies {
                    cell.configUI(img: moviesData?.body?.data?.banner?[0].imagery?.banner ?? "")
                }else if category == .tvShows {
                    cell.configUI(img: tvShowsData?.body?.data?.banner?[0].imagery?.banner ?? "")
                }else if category == .subCategory {
                    cell.configUI(img: subCategoryData?.body?.data?.banner?.imagery?.banner ?? "")
                }
                
                return cell
            }
        }
        else{
            if category == .subCategory {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
                    cell.configUI(urlString: subCategoryData?.body?.data?.playlists?[indexPath.row].imagery?.thumbnail ?? "")
                    return cell
                }
            }
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell {
                cell.delegate = self
                
                if category == .home {
                    cell.updateUI(data: homeData?.body?.data?.playlists?[indexPath.section-1])
                }else if category == .movies {
                    cell.updateUI(data: moviesData?.body?.data?.playlists?[indexPath.section-1])
                }else if category == .tvShows {
                    cell.updateUI(data: tvShowsData?.body?.data?.playlists?[indexPath.section-1])
                }
            
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section > 0 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LabelCollectionReusableView", for: indexPath) as? LabelCollectionReusableView{
                if category == .home {
                    header.configUI(title: homeData?.body?.data?.playlists?[indexPath.section-1].title ?? "")
                }else if category == .movies {
                    header.configUI(title: moviesData?.body?.data?.playlists?[indexPath.section-1].title ?? "")
                }else if category == .tvShows {
                    header.configUI(title: tvShowsData?.body?.data?.playlists?[indexPath.section-1].title ?? "")
                }
            
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
            if category == .subCategory {
                return CGSize(width: (screenWidth-8)/3, height: (screenWidth-8)/3)
            }
            return CGSize(width: screenWidth, height: screenWidth/2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
           return CGSize(width: 0, height: 0)
        }else{
            if category == .subCategory {
                return CGSize.zero
            }
            return CGSize(width: screenWidth, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if category == .subCategory {
            return 4
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if category == .subCategory {
            return 4
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if category == .home {
                delegate?.videoTapped(video: homeData?.body?.data?.banner?[0])
            }else if category == .movies {
                delegate?.videoTapped(video: moviesData?.body?.data?.banner?[0])
            }else if category == .tvShows {
                delegate?.videoTapped(video: tvShowsData?.body?.data?.banner?[0])
            }else if category == .subCategory {
                delegate?.videoTapped(video: subCategoryData?.body?.data?.banner)
            }
        }else if category == .subCategory {
            delegate?.videoTapped(video: subCategoryData?.body?.data?.playlists?[indexPath.row])
        }
    }
}

extension HomeTabView: MenuViewDelegate {
    func logoButtonTapped() {
        delegate?.logoButtonTapped()
    }
    
    func tvButtonTapped() {
        delegate?.tvButtonTapped()
    }
    
    func tvSubButtonTapped() {
        delegate?.tvSubButtonTapped()
    }
    
    func moviesButtonTapped() {
        delegate?.moviesButtonTapped()
    }
    
    func movieSubButtonTapped() {
        delegate?.movieSubButtonTapped()
    }
    
    func myListButtonTapped() {
        
    }
    
    func castTapped() {
        
    }
    
    func homeCategoriesTapped(category: CurrentSection) {
        if category == .tvShow {
            print("TV Shows tapped")
        }else if category == .movie {
            print("Movies tapped")
        }else if category == .myList {
            print("My List tapped")
        }
        delegate?.homeCategoriesTapped()
    }
}

extension HomeTabView: MainCollectionViewCellDelegate {
    func videoTapped(video: Video?) {
        delegate?.videoTapped(video: video)
    }
}
