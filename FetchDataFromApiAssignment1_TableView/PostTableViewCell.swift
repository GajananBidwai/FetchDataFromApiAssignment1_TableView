//
//  PostTableViewCell.swift
//  FetchDataFromApiAssignment1_TableView
//
//  Created by Mac on 19/12/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
