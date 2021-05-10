//
//  FollowersScreenViewModel.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit

/*
 View model for the followers screen.
 Handles API call, setups table view manager and listens to tap action
 */

class FollowersScreenViewModel: NSObject {

    private weak var view: ScreenUpdatable?
    private var tableViewManager: TableViewManager?
    private var followersUrlString: String

    init(_ context: UIViewController?, and followersUrlString: String) {
        self.followersUrlString = followersUrlString
        super.init()
        let viewController = FollowersViewController(self)
        self.view = viewController
        self.tableViewManager = TableViewManager(self)
        self.tableViewManager?.updateItems(with: nil)
        self.pushViewController(inContext: context)
    }

    func assignTableViewManager(_ tableView: UITableView) {
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
    }

    func loadDataOnScreen() {
        fetchFollowers()
    }

    private func fetchFollowers() {
        Networking.sharedInstance.getFollowersForUser(usingUrl: followersUrlString) { [weak self] (response, error) in
            guard let self = self else { return }

            guard let followers = response,
                  followers.count > 0 else {
                self.tableViewManager?.updateItems(with: nil)
                self.view?.reloadForSearchSuccessState(.failure)
                return
            }
            self.tableViewManager?.updateItems(with: followers)
            self.view?.reloadForSearchSuccessState(.success)
        }
    }

    private func pushViewController(inContext context: UIViewController?) {
        context?.navigationController?.pushViewController(self.view as! UIViewController,
                                                          animated: true)
    }
}

extension FollowersScreenViewModel: TableViewActionHandler {

    func navigateToFollowersScreen(withUrl followersUrlString: String) {
        _ = FollowersScreenViewModel(view as? UIViewController,
                                     and: followersUrlString)
    }
}
