//
//  TextCell.swift
//  ParseChat
//
//  Created by Wenn Huang on 2/23/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var usernameLable: UILabel!
    var post: Post? {
        didSet {
            textMessage.text = post?.text
            if let user = post?.author {
                usernameLable.text = user
                usernameLable.isHidden = false
                
            }else{
                usernameLable.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
