//
//  HomeScreenViewModel.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit


class HomeScreenViewModel: NSObject {

    private weak var view: ScreenUpdatable?
    private var users: [UserDetails]?

    init(_ view: ScreenUpdatable?) {
        self.view = view
        self.users = nil
    }


    func handleSearchAction(forQueryString queryString: String?) {
        guard let queryString = queryString,
              !queryString.isEmpty else {
            view?.reloadForSearchSuccessState(.failure)
            return
        }
        getUsersWithQueryString(queryString)
    }

    private func getUsersWithQueryString(_ queryString: String) {
        Networking.sharedInstance.getUsersMatchingSearchedQuery(queryString) { [weak self] (response, error) in
            guard let self = self else { return }

            guard let response = response,
                  response.totalCount > 0,
                  response.incompleteResults == false,
                  let users = response.items else {
                self.users = nil
                self.view?.reloadForSearchSuccessState(.failure)
                return
            }
            self.users = users
            self.view?.reloadForSearchSuccessState(.success)
        }
    }

    private func navigateToFollowersScreen(withUrl followersUrlString: String) {
        _ = FollowersScreenViewModel(view as? UIViewController,
                                     and: followersUrlString)
    }
}

extension HomeScreenViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let users = self.users,
              indexPath.row < users.count else {
            assertionFailure("Count mismatch")
            return
        }

        guard let followersUrl = users[indexPath.row].followersUrl else {
            assertionFailure("Followers URL not available")
            return
        }

        navigateToFollowersScreen(withUrl: followersUrl)
    }
}
