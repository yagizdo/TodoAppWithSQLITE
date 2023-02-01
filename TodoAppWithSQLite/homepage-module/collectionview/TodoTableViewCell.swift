//
//  TodoTableViewCell.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 1.02.2023.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoTitleLabel: UILabel!
    
    
    @IBOutlet weak var todoDescLabel: UILabel!
    
    @IBOutlet weak var todoCellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
