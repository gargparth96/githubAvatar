//
//  TableViewActionHandler.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

/*
 This passes the tap action from the table view manager to the view models
 */

protocol TableViewActionHandler: class {
    func navigateToFollowersScreen(withUrl followersUrlString: String)
}

