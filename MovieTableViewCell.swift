//
//  MovieTableViewCell.swift
//  reflexionCompanyTask
//
//  Created by Mac on 17/01/35.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

//MARK - IBOutlet of labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
