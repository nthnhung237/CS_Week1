//
//  DeitailMoviesViewController.swift
//  Movies
//
//  Created by Long Nguyen on 6/16/17.
//  Copyright © 2017 Long Nguyen. All rights reserved.
//

import UIKit

class DeitailMoviesViewController: UIViewController {

    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var tbvDetail: UITableView!
    
    var urlImageDetail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
