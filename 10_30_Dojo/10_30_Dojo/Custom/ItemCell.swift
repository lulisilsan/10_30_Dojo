//
//  ItemCell.swift
//  10_30_Dojo
//
//  Created by Luciana on 02/11/20.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    
    func setup(item: Item) {
        labelName.text = item.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
