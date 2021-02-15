//
//  CostCell.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit

class CostCell: UITableViewCell {

    @IBOutlet weak var nameCategory: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var money: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
