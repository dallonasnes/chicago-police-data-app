//
//  ViewController.swift
//  AngryOinkers
//
//  Created by dev on 9/29/20.
//

import UIKit

class PigListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //apparently sounder is what you call a group of pigs, so we'll go with it
    var sounder: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.sounder = ["Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C",
                        "Pig A", "Pig B", "Pig C"]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
}

extension PigListViewController : UITableViewDataSource {
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "pigCell")!
        
        cell.textLabel?.text = self.sounder[indexPath.row]
        
        return cell
    }
}

extension PigListViewController : UITableViewDelegate {
    //MARK: Delegate
}
