//
//  EntryTableViewCell.swift
//  Journal (Core Data)
//
//  Created by Kevin Stewart on 2/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateViews()
    }
    
    // MARK: - Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }

    
    // MARK: - Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var entryLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Methods
    
    func updateViews() {
        titleLabel.text = entry?.title
        entryLabel.text = entry?.bodyText
        
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "EST")
        formatter.dateFormat = "MM/dd/yyyy h:mm a"
        
        dateLabel.text = formatter.string(from: entry?.timestamp ?? Date())
    }
    
    
}
