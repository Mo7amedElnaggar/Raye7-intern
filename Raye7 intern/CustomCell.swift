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

    // For make Shadow and roundCorners
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .none
        
        cellText.isEditable = false // You can not change its Content
        
        cellView.layer.cornerRadius = 15
        
        //makeShadow()

    }
    
    func initializeCell(data: (String , String)) {
        // set cellTitle and cellText
        cellTitle.text = data.0
        cellText.text = data.1
    }
    
    private func makeShadow() {
        
        cellView.layer.shadowColor = UIColor.green.cgColor
        cellView.layer.shadowOpacity =  0.5
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 10
        cellView.layer.shadowPath = UIBezierPath(rect: cellView.bounds).cgPath
        cellView.layer.shouldRasterize = true

        
        
    }
    
}
