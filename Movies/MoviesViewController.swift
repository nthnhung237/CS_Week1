//
//  MoviesViewController.swift
//  Movies
//
//  Created by Long Nguyen on 6/16/17.
//  Copyright © 2017 Long Nguyen. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController {

    @IBOutlet weak var tbvMovies: UITableView!
    @IBOutlet weak var sbMovies: UISearchBar!
    
    var data = [NSDictionary]()
    let postfirstURL = "https://image.tmdb.org/t/p/w342"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbvMovies.delegate = self
        tbvMovies.dataSource = self
        loadData()
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
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        
        if let url = url {
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
                            }
                        }
                    }
            })
            task.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! DeitailMoviesViewController
        let indexPath = tbvMovies.indexPath(for: sender as! UITableViewCell)
        desVC.urlImageDetail = postfirstURL + (data[(indexPath?.row)!]["poster_path"] as! String)
    }

}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "IDCell", for: indexPath) as? MoviesTableViewCell
        Cell?.lbTitleMovies.text = data[indexPath.row]["original_title"] as? String
        Cell?.lbContenMovies.text = data[indexPath.row]["overview"] as? String
        let urlPostImage = postfirstURL + (data[indexPath.row]["poster_path"] as! String)
        Cell?.igMovies.setImageWith(NSURL(string: urlPostImage)! as URL)
        return Cell!
    }
}
