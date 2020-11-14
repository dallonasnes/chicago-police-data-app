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
    var sounder: [Pig] = []
    var pigService: PigService!
    
    //our default pig when the API fails
    let alonePig = Pig(
        named: "alone pig",
        role: "placeholder while we retry api call :) ",
        page_url: "",
        complaint_count: 25,
        total_payments: 665434
        )
    
    //Note: I had implemented the spinner previously so adding this comment to show a diff of where it lives
    var spinner = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.startAnimating()
        self.view.addSubview(spinner)
        
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.pigService = PigService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let confirmedService = self.pigService else { return }
        confirmedService.getPigs(completion: { pigs, error in
            //pigs.count!=0 checks to make sure we don't just return an empty list
            guard let pigs = pigs, pigs.count != 0, error == nil else {
                
                let alert = UIAlertController(title: "Are you connected to internet?", message: "Try connecting to internet, then press retry to fetch pig data", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    self.sounder = [self.alonePig];
                    self.spinner.removeFromSuperview()
                    self.tableView.reloadData()
                    return
                }))
                
                //retry logic in here
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                    
                    
                    confirmedService.getPigs(completion: { mPigs, mError in
                        guard let mPigs = mPigs, mPigs.count != 0, mError == nil else {
                            self.sounder = [self.alonePig];
                            self.spinner.removeFromSuperview()
                            self.tableView.reloadData()
                            return
                        }
                        
                        self.sounder = mPigs
                        self.spinner.removeFromSuperview()
                        self.tableView.reloadData()
                        return
                        
                    })
                    
                    self.sounder = [self.alonePig];
                    self.spinner.removeFromSuperview()
                    self.tableView.reloadData()
                    return
                }))
                
                
                self.present(alert, animated: true)
                return
            }
            
            self.sounder = pigs
            self.spinner.removeFromSuperview()
            self.tableView.reloadData()
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? PigCell
        else { return }
        
        let confirmedPig = confirmedCell.pig
        destination.pig = confirmedPig
        destination.pigCell = confirmedCell
    }
    
}

extension PigListViewController : UITableViewDataSource {
    //MARK: DataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounder.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "pigCell") as! PigCell
        
        let currentPig = self.sounder[indexPath.row]
        cell.pig = currentPig
        
        return cell
    }
}

extension PigListViewController : UITableViewDelegate {
    //MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {

    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = self.tableView.cellForRow(at: indexPath) as! PigCell
        let complete = completeAction(at: indexPath, cell)
        return UISwipeActionsConfiguration(actions: [complete])
    }
    
    private func completeAction(at indexPath: IndexPath, _ cell: PigCell) -> UIContextualAction {
        let pig = cell.pig!
        let action = UIContextualAction(style: .normal, title: pig.confirmedOingry ? "NotOingry" : "Oingry") { (action, view, completion) in
            pig.confirmedOingry = !pig.confirmedOingry
            completion(true)
        }
        
        if !pig.confirmedOingry {
            let flame = UIImageView(frame: CGRect(x: 0, y: 65, width: 25, height: 30))
            flame.image = UIImage(systemName: "flame.fill")
            flame.tintColor = .systemRed
            cell.accessoryView = flame
        } else {
            cell.accessoryView = .none
        }
        
        return action
    }
    
    
}
