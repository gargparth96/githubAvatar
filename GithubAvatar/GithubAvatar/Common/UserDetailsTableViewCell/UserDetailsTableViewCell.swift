//
//  UserDetailsTableViewCell.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var seeFollowersArrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // TODO: Setup avatar image
    func setup(with userDetails: UserDetails) {
        nameLabel.text = userDetails.login
        if let followersUrl = userDetails.followersUrl,
           !followersUrl.isEmpty {
            seeFollowersArrowImageView.isHidden = false
        } else {
            seeFollowersArrowImageView.isHidden = true
        }
    }
}
