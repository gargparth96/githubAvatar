//
//  TableViewManager.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit

/*
 Setting the table views on both the screen using a single manager.
 Takes a view model as TableViewActionHandler.
 This need to be updated on items change from view models.
 */

class TableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var items: [UserDetails]?
    private weak var actionHandler: TableViewActionHandler?

    init(_ actionHandler: TableViewActionHandler) {
        self.actionHandler = actionHandler
    }

    func updateItems(with items: [UserDetails]?) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let items = self.items,
              indexPath.row < items.count,
              let userdetailsCell = tableView.dequeueReusableCell(withIdentifier: UserDetailsTableViewCell.reuseIdentifier, for: indexPath) as? UserDetailsTableViewCell else {
            return UITableViewCell()
        }

        userdetailsCell.setup(with: items[indexPath.row])
        return userdetailsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = self.items,
              indexPath.row < items.count else {
            assertionFailure("Count mismatch")
            return
        }

        guard let followersUrl = items[indexPath.row].followersUrl else {
            assertionFailure("Followers URL not available")
            return
        }

        actionHandler?.navigateToFollowersScreen(withUrl: followersUrl)
    }
}
