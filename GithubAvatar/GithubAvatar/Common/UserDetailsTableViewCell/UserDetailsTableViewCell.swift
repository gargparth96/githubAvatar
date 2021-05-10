//
//  UserDetailsTableViewCell.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import UIKit

/*
 Cell to display the user avatar and name.
 Also displays an arrow depicting the presence of followers url
 */

class UserDetailsTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var seeFollowersArrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with userDetails: UserDetails) {
        avatarImageView.setImage(using: userDetails.avatarUrl,
                                 andDefaultImage: "person.crop.square")
        nameLabel.text = userDetails.login
        if let followersUrl = userDetails.followersUrl,
           !followersUrl.isEmpty {
            seeFollowersArrowImageView.isHidden = false
        } else {
            seeFollowersArrowImageView.isHidden = true
        }
    }
}
