//
//  SplashViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 27/09/21.
//

import UIKit
import CoreLocation

class SplashViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoImageWidth: NSLayoutConstraint!

    var locationManger: CLLocationManager?
    var category: Category = .home
    let dispatchGroup = DispatchGroup()
    let concurrentQueue = DispatchQueue(label: "com.ottapp.Concurrent", attributes: .concurrent)
    var dataFetchComplete: Bool = false
    var isAnimationComplete: Bool = false
    var permissionGranted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForPermission()
        
        checkLoggedStatus()
        
        dispatchGroup.notify(queue: .main) {
            print("dispatchGroup notifier")

            if self.isAnimationComplete {
                let controller = Controllers.users.getControllers()
                self.navigationController?.pushViewController(controller, animated: true)
            }else {
                self.dataFetchComplete = true
            }
        }
    }
    
    func requestForLocationAuthorization() {
        locationManger = CLLocationManager()
        locationManger?.delegate = self
        locationManger?.requestAlwaysAuthorization()
    }
    
    func requestLocation() {
        locationManger = CLLocationManager()
        locationManger?.delegate = self
        locationManger?.requestLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpUI()
    }
    
    func checkForPermission() {
        let status = CLLocationManager.authorizationStatus()

        switch status {
            case .authorizedAlways:
                requestLocation()
            case .authorizedWhenInUse:
                requestLocation()
            case .denied:
                requestForLocationAuthorization()
            case .notDetermined:
                requestForLocationAuthorization()
            case .restricted:
                requestForLocationAuthorization()
        @unknown default:
            print("")
        }
    }
    
    func setUpUI() {
        guard let netflixLogoImage = Images.shared.netflixGif else { return }
        
        logoImage.animationImages = netflixLogoImage.images
        logoImage.animationDuration = netflixLogoImage.duration
        logoImage.animationRepeatCount = 1
        logoImage.startAnimating()
        
        logoImageWidth.constant = screenWidth - 80
        
        UIView.animate(withDuration: 1.2, animations: { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.logoImage.frame.origin.x = strongSelf.view.frame.origin.x + 40
        }) { [weak self] (bool) in
            if bool {
                guard let strongSelf = self else { return }
                
                strongSelf.logoImage.image = Images.shared.netflixImage
                strongSelf.animationComplete()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
    }
    
    func animationComplete() {
        if dataFetchComplete {
            let controller = Controllers.users.getControllers()
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            isAnimationComplete = true
        }
    }
    
    func checkLoggedStatus() {
        if let isLoggedIn = UserDefaults.standard.value(forKey: kLoggedIn) as? Bool {
            if isLoggedIn {
                dispatchGroup.enter()
                concurrentQueue.async {
                    self.getData()
                }
                
                dispatchGroup.enter()
                concurrentQueue.async {
                    self.getMovieCategories()
                }
                
                dispatchGroup.enter()
                concurrentQueue.async {
                    self.getTvShowsCategories()
                }
            }else {
                let controller = Controllers.login.getControllers()
                navigationController?.viewControllers = [controller]
            }
        }else {
            let controller = Controllers.login.getControllers()
            navigationController?.viewControllers = [controller]
        }
    }

    
    
    func getData() {
        self.category = .home
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
    
        NetworkAdaptor.request(url: ApiHandler.home.url(), method: .get,headers: headers) { data, response, error in
            do{
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    if let data = data {
                        let homeData = try JSONDecoder().decode(Home.self, from: data)
                        AppData.shared.homeData = homeData
                        print("Get Home Data Success")
                        self.dispatchGroup.leave()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
//    func getTvShowsData() {
//        self.category = .tvShows
//
//        var headers : [String:String] = [:]
//        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
//
//        NetworkAdaptor.request(url: ApiHandler.tvshows.url(), method: .get,headers: headers) { data, response, error in
//            do{
//                if let error = error {
//                    print(error.localizedDescription)
//                }else{
//                    if let data = data {
//                        let tvShowsData = try JSONDecoder().decode(Home.self, from: data)
//                    }
//                }
//            }
//
//            catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    func getMoviesData() {
//        self.category = .movies
//
//        var headers : [String:String] = [:]
//        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
//
//        NetworkAdaptor.request(url: ApiHandler.movies.url(), method: .get,headers: headers) { data, response, error in
//            do{
//                if let error = error {
//                    print(error.localizedDescription)
//                }else{
//                if let data = data {
//                    let moviesData = try JSONDecoder().decode(Home.self, from: data)
//                  //  print(moviesData)
//                   // self.delegate?.updateUI()
//                }
//                }
//            }
//            catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    
    func getMovieCategories() {
        let urlString = "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/moviecategories"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: headers, urlParameters: nil, bodyParameters: nil) { data, response, error in
            if error == nil {
                if let data = data {
                    do {
                        let moviesCategoriesData = try JSONDecoder().decode(CategoryModel.self, from: data)
                        AppData.shared.moviesCategoriesData = moviesCategoriesData
                        print("Get moviesCategoriesData Success")
                    }catch  {
                        print(error.localizedDescription)
                    }
                    self.dispatchGroup.leave()
                }
            }else {
                print("Show Alert")
            }
        }
    }
    
    func getTvShowsCategories() {
        let urlString = "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/tvcategories"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: headers, urlParameters: nil, bodyParameters: nil) { data, response, error in
            if error == nil {
                if let data = data {
                    do {
                        let tvCategoriesData = try JSONDecoder().decode(CategoryModel.self, from: data)
                        AppData.shared.tvCategoriesData = tvCategoriesData
                        print("Get tvCategoriesData Success")
                    }catch  {
                        print(error.localizedDescription)
                    }
                    self.dispatchGroup.leave()
                }
            }else {
                print("Show Alert")
            }
        }
    }
    
    
    
}


extension SplashViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first?.coordinate.latitude, locations.first?.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedAlways:
                if !permissionGranted {
                    print("authorizedAlways")
                    permissionGranted = true
                    requestLocation()
                }
            case .authorizedWhenInUse:
                if !permissionGranted {
                    print("authorizedWhenInUse")
                    permissionGranted = true
                    requestLocation()
                }
            case .denied:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
        @unknown default:
            print("")
        }
    }
}
