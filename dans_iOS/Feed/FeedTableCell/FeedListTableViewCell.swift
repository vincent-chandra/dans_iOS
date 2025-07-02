//
//  FeedListTableViewCell.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

protocol FeedListTableCellDelegate: AnyObject {
    func bookmarkButtonTapped(index: Int)
}

class FeedListTableViewCell: UITableViewCell {

    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    weak var delegate: FeedListTableCellDelegate?
    var index = 0
    var isBookmarked = false {
        didSet {
            bookmarkButton.setImage(isBookmarked ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookmarkButton.addTarget(self, action: #selector(tapBookmarkButton), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        // Cancel ongoing task & reset state
        authorImage?.image = nil
    }
    
    @objc private func tapBookmarkButton() {
        self.delegate?.bookmarkButtonTapped(index: index)
    }
}
