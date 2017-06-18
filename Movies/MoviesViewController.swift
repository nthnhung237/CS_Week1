//
//  MoviesViewController.swift
//  Movies
//
//  Created by Long Nguyen on 6/16/17.
//  Copyright © 2017 Long Nguyen. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UISearchBarDelegate, UITabBarDelegate {

    @IBOutlet weak var tbvMovies: UITableView!
    let searchController = UISearchController (searchResultsController: nil)
    
    var data = [NSDictionary]()
    let postfirstURL = "https://image.tmdb.org/t/p/w342"
    let ipaNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let ipaTopRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var filteredMovies = [String]()
    var arTitle = [String]()
    var refreshControl = UIRefreshControl()
    var urlipa: URL?
    let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        tbvMovies.delegate = self
        tbvMovies.dataSource = self
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tbvMovies.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self as UISearchBarDelegate
        if self.tabBarController?.selectedIndex == 0 {
            urlipa = URL(string: ipaNowPlaying)
            loadData()
            refreshControl.addTarget(self, action: #selector(MoviesViewController.loadData), for: UIControlEvents.valueChanged)
            tbvMovies.insertSubview(refreshControl, at: 0)
        } else {
            urlipa = URL(string: ipaTopRated)
            loadData()
            refreshControl.addTarget(self, action: #selector(MoviesViewController.loadData), for: UIControlEvents.valueChanged)
            tbvMovies.insertSubview(refreshControl, at: 0)
        }
        checkConnection()
        waitting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func loadData() {
        if let url = urlipa {
            let request = URLRequest(
                url: url,
                cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                timeoutInterval: 10)
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: nil,
                delegateQueue: OperationQueue.main)
            let task = session.dataTask(
                with: request,
                completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            if let Data = responseDictionary["results"] as? [NSDictionary] {
                                self.data = Data
                                self.tbvMovies.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        }
                    }
            })
            task.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationController?.isNavigationBarHidden = false
        let desVC = segue.destination as! DeitailMoviesViewController
        let indexPath = tbvMovies.indexPath(for: sender as! UITableViewCell)
        desVC.urlImageDetail = postfirstURL + (data[(indexPath?.row)!]["poster_path"] as! String)
        desVC.date = data[(indexPath?.row)!]["release_date"] as! String
        desVC.name = data[(indexPath?.row)!]["original_title"] as! String
        desVC.content = data[(indexPath?.row)!]["overview"] as! String
        let vote = data[(indexPath?.row)!]["vote_average"] as! Int
        let voter = vote * 10
        desVC.voterate = voter
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController.selectedIndex)
    }
    
    func checkConnection(){
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status: AFNetworkReachabilityStatus?) in
            switch status!.hashValue{
            case AFNetworkReachabilityStatus.notReachable.hashValue:
                let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                print("No Internet Connection")
                self.tbvMovies.reloadData()
                self.refreshControl.endRefreshing()
                break;
            case AFNetworkReachabilityStatus.reachableViaWiFi.hashValue,AFNetworkReachabilityStatus.reachableViaWWAN.hashValue:
                self.refreshControl.endRefreshing()
                break;
            default:
                print("unknown")
            }
            
        }
    }
    
    func waitting()  {
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 130, width: 320, height: 100))
        loadingView.startAnimating()
        loadingView.center = tableFooterView.center
        tableFooterView.addSubview(loadingView)
        tbvMovies.tableFooterView = tableFooterView
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchController.isActive && searchController.searchBar.text! != "" {
                return filteredMovies.count
            } else {
                return data.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "IDCell", for: indexPath) as? MoviesTableViewCell
        
            let title = data[indexPath.row]["original_title"] as? String
            arTitle.insert(title!, at: indexPath.row)
            if searchController.isActive && searchController.searchBar.text! != "" {
                Cell?.lbTitleMovies.text = filteredMovies[indexPath.row]
            } else {
                Cell?.lbTitleMovies.text = data[indexPath.row]["original_title"] as? String
            }
            Cell?.lbContenMovies.text = data[indexPath.row]["overview"] as? String
            let urlPostImage = postfirstURL + (data[indexPath.row]["poster_path"] as! String)
            Cell?.igMovies.setImageWith(NSURL(string: urlPostImage)! as URL)
            return Cell!
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    func updateSearchResults(for searchController: UISearchController) {
        filteredMovies.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (arTitle as NSArray).filtered(using: searchPredicate)
        filteredMovies = array as! [String]
        self.tbvMovies.reloadData()
    }
    
}
