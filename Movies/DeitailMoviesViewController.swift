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
    @IBOutlet weak var srollContend: UIScrollView!
    @IBOutlet weak var viewContend: UIView!
    
    @IBOutlet weak var lbNam: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContend: UILabel!
    
    var urlImageDetail = String()
    var date = String()
    var content = String()
    var name = String()
    var voterate = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgDetail.setImageWith(NSURL(string: urlImageDetail)! as URL)
        // Do any additional setup after loading the view.
        self.srollContend.contentSize = CGSize(width: self.srollContend.frame.size.width, height: self.viewContend.frame.origin.y + self.viewContend.frame.height)
        self.lbNam.text = name
        self.lbDate.text = date
        self.lbContend.text = content
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
