//
//  DeitailMoviesViewController.swift
//  Movies
//
//  Created by Long Nguyen on 6/16/17.
//  Copyright © 2017 Long Nguyen. All rights reserved.
//

import UIKit

class DeitailMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var tbvDetail: UITableView!
    
    var urlImageDetail = String()
    var date = String()
    var content = String()
    var name = String()
    var voterate = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgDetail.setImageWith(NSURL(string: urlImageDetail)! as URL)
        tbvDetail.delegate = self
        tbvDetail.dataSource = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "IDDetailCell", for: indexPath) as? DetailTableViewCell
        Cell?.lbDate.text = date 
        Cell?.lbName.text = name
        Cell?.lbContend.text = content
        return Cell!
    }
}
