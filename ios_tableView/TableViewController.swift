//
//  ViewController.swift
//  ios_tableView
//
//  Created by Profit, Holden on 11/16/16.
//  Copyright © 2016 Profit, Holden. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView?
    var data: Array<JSON> = []
    
    func parseIMBDResults (result: Any?) {
        if let jsonValue = result {
            data = JSON(jsonValue)["Search"].arrayValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://www.omdbapi.com/?page=10&s=halloween").responseJSON { response in
            self.parseIMBDResults(result: response.result.value)
            self.table?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // MARK: - Cell Fill Function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]["Title"].string
        
        return cell
    }
    
    // MARK: - Cell Click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        //let destination = DetailViewController()
        //navigationController?.pushViewController( destination, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        navigationController?.pushViewController(destination, animated: true)
    }
}

