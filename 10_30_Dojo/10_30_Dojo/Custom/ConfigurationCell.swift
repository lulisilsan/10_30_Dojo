//
//  ConfigurationCell.swift
//  10_30_Dojo
//
//  Created by Luciana on 02/11/20.
//

import UIKit

class ConfigurationCell: UITableViewCell {
    
    @IBOutlet weak var labelConfiguration: UILabel!
    
    func setup(title: Configuration) {
        labelConfiguration.text = title.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
