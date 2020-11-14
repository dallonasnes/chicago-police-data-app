//
//  DetailViewController.swift
//  AngryOinkers
//
//  Created by dev on 10/16/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pigRoleLabel: UILabel!
    
    var pig: Pig!
    var pigCell: PigCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pigRoleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pigRoleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        pigRoleLabel.text = "As " + pig.role + " this lil piggy had \(pig.complaint_count) complaints and cost us taxpayers  \(pigCell.pigDescriptionLabel.text!) in misconduct settlements! OINK! "
        pigRoleLabel.numberOfLines = 0
        pigRoleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        pigRoleLabel.adjustsFontSizeToFitWidth = true
        pigRoleLabel.textAlignment = NSTextAlignment.center
        pigRoleLabel.sizeToFit()
        
        view.addSubview(pigRoleLabel)
        
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
