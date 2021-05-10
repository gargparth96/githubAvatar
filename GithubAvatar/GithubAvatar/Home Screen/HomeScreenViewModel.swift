//
//  HomeScreenViewModel.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit

/*
 View model for the followers screen.
 Handles search query, API call, setups table view manager and listens to tap action.
 */

class HomeScreenViewModel: NSObject {

    private weak var view: ScreenUpdatable?
    private var tableViewManager: TableViewManager?

    init(_ view: ScreenUpdatable?) {
        self.view = view
        super.init()
        self.tableViewManager = TableViewManager(self)
        self.tableViewManager?.updateItems(with: nil)
    }

    func assignTableViewManager(_ tableView: UITableView) {
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
    }

    func handleSearchAction(forQueryString queryString: String?) {
        guard let queryString = queryString,
              !queryString.isEmpty else {
            view?.reloadForSearchSuccessState(.failure)
            return
        }
        fetchUsersWithQueryString(queryString)
    }

    private func fetchUsersWithQueryString(_ queryString: String) {
        Networking.sharedInstance.getUsersMatchingSearchedQuery(queryString) { [weak self] (response, error) in
            guard let self = self else { return }

            guard let response = response,
                  response.totalCount > 0,
                  response.incompleteResults == false,
                  let users = response.items else {
                self.tableViewManager?.updateItems(with: nil)
                self.view?.reloadForSearchSuccessState(.failure)
                return
            }
            self.tableViewManager?.updateItems(with: users)
            self.view?.reloadForSearchSuccessState(.success)
        }
    }
}

extension HomeScreenViewModel: TableViewActionHandler {

    func navigateToFollowersScreen(withUrl followersUrlString: String) {
        _ = FollowersScreenViewModel(view as? UIViewController,
                                     and: followersUrlString)
    }
}
