//
//  CustomCell.swift
//  Raye7 intern
//
//  Created by Mohamed El Naggar on 6/7/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initializeCell(data: (String , String)) {
        // set cellTitle and cellText
        cellTitle.text = data.0
        cellText.text = data.1
    }
}
