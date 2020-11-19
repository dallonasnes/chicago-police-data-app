//
//  DetailViewController.swift
//  AngryOinkers
//
//  Created by dev on 10/16/20.
//

import UIKit
import MessageUI

let mayorEmailAddress = "letterforthemayor@cityofchicago.org"
//let alderEmailAddresses = []

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pigRoleLabel: UILabel!
    @IBOutlet weak var contactRepsButton: UIButton!
    @IBAction func contactRepsButtonClick(_ sender: Any) {
        self.sendEmail()
    }
    
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
    
}

//instructions: https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email
extension DetailViewController: MFMailComposeViewControllerDelegate {
    internal func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([mayorEmailAddress])
            //mail.setBccRecipients(alderEmailAddresses)
            mail.setSubject("Why haven't you fired \(self.pig.name) from the police department?")
            mail.setMessageBody("Investigations from Chicago Reporter and CPDP.co indicate that \(self.pig.name) is still active on the police force despite being named in misconduct settlements that cost at least \(self.pig.total_payments_string) and receiving at least \(self.pig.complaint_count) complaints.\n\n As a resident of Chicago, I'm concerned that someone with such a history of misconduct is still on the job.\n\n Can you please verify this data is correct, or provide open data instead of making journalists find it themselves? \n\n And please expain why you haven't fired this officer, despite knowing their history of misconduct makes us unsafe.\n\n Sincerely,\n a concerned Chicagoan", isHTML: false)

            present(mail, animated: true)
        } else {
            // show failure alert
            print("failed to send email")
        }
    }

    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
