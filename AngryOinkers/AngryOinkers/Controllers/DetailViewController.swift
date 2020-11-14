//
//  DetailViewController.swift
//  AngryOinkers
//
//  Created by dev on 10/16/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pigRoleLabel: UILabel!
    @IBOutlet weak var contactRepsButton: UIButton!
    
    var pig: Pig!
    var pigCell: PigCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pigRoleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pigRoleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        pigRoleLabel.text = "Role: " + pig.role + "\nComplaints: \(pig.complaint_count) \n\(pigCell.pigDescriptionLabel.text!)"
        pigRoleLabel.numberOfLines = 0
        pigRoleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        view.addSubview(pigRoleLabel)
        
        contactRepsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contactRepsButton.topAnchor.constraint(equalTo: pigRoleLabel.bottomAnchor).isActive = true
        view.addSubview(contactRepsButton)
        
    }
    

    /*
    // MARK: - Navigation
     
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
