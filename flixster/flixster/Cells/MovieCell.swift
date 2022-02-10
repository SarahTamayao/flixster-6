//
//  MovieCell.swift
//  flixster
//
//  Represents a table row cell containing movie image, title, and synopsis
//  Created by Giovanni Propersi on 2/2/22.
//

import UIKit

class MovieCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    // MARK: - Table cell functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
