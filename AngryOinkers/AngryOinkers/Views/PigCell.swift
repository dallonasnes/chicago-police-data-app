//
//  PigCell.swift
//  AngryOinkers
//
//  Created by dev on 9/29/20.
//

import UIKit

class PigCell: UITableViewCell {
    
    @IBOutlet weak var pigNameLabel: UILabel!
    @IBOutlet weak var pigDescriptionLabel: UILabel!
    @IBOutlet weak var pigImageView: UIImageView!
    
    var pig: Pig? {
        didSet {
            self.pigNameLabel.text = pig?.name
            let nf = NumberFormatter();
            nf.numberStyle = .decimal;
            self.pigDescriptionLabel.text = "$" + nf.string(from: NSNumber(value: pig!.total_payments))!
            self.accessoryType = pig!.confirmedSighting ? .checkmark : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                guard
                    let confirmedPigImageUrl = URL(string: self.pig!.imageUrl),
                      let pigImageData = NSData(contentsOf: confirmedPigImageUrl),
                      let pigImage = UIImage(data: pigImageData as Data)
                else { return }
                DispatchQueue.main.async {
                    self.pigImageView.image = pigImage
                    self.pigImageView.layer.cornerRadius = self.pigImageView.frame.width / 2
                }
            }
            
            if pig!.confirmedOingry {
                let flame = UIImageView(frame: CGRect(x: 0, y: 65, width: 25, height: 30))
                flame.image = UIImage(systemName: "flame.fill")
                flame.tintColor = .systemRed
                self.accessoryView = flame
            } else {
                self.accessoryView = .none
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
