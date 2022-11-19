//
//  MyTableViewCell.swift
//  StarWars1
//
//  Created by Home on 11/11/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var NameCharacter: UILabel!
    
    @IBOutlet weak var EyeCharacter: UILabel!
    
    @IBOutlet weak var HairCharacter: UILabel!
    
    @IBOutlet weak var PlanetCharacter: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
