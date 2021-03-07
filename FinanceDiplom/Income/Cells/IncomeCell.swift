//
//  IncomeCell.swift
//  FinanceDiplom
//
//  Created by Зоригто Бадмаин on 15.02.2021.
//

import UIKit

class IncomeCell: UITableViewCell {
    
    @IBOutlet weak var incomeLabel: UILabel!
    
    let items = Persistence.shared.getItemsIcome()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(index: Int) {
        let item = items[index]
        incomeLabel.text = "\(item.income) руб."
    }

}
