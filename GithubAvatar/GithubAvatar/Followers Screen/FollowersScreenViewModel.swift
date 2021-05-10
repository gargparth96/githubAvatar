//
//  FollowersScreenViewModel.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit

class FollowersScreenViewModel: NSObject {

    private weak var view: ScreenUpdatable?
    private var followers: [UserDetails]?
    private var followersUrlString: String

    init(_ context: UIViewController?, and followersUrlString: String) {
        let viewController = FollowersViewController()
        self.view = viewController
        self.followersUrlString = followersUrlString
        self.followers = nil
        super.init()
        self.pushViewController(inContext: context)
    }

    func loadDataOnScreen() {
        fetchFollowers()
    }

    private func fetchFollowers() {
        Networking.sharedInstance.getFollowersForUser(usingUrl: followersUrlString) { [weak self] (response, error) in
            guard let self = self else { return }

            guard let followers = response,
                  followers.count > 0 else {
                self.followers = nil
                self.view?.reloadForSearchSuccessState(.failure)
                return
            }
            self.followers = followers
            self.view?.reloadForSearchSuccessState(.success)
        }
    }

    private func pushViewController(inContext context: UIViewController?) {
        context?.navigationController?.pushViewController(self.view as! UIViewController,
                                                          animated: true)
    }

    private func navigateToFollowersScreen(withUrl followersUrlString: String) {
        _ = FollowersScreenViewModel(view as? UIViewController,
                                     and: followersUrlString)
    }
}

extension FollowersScreenViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let followers = self.followers,
              indexPath.row < followers.count else {
            assertionFailure("Count mismatch")
            return
        }

        guard let followersUrl = followers[indexPath.row].followersUrl else {
            assertionFailure("Followers URL not available")
            return
        }

        navigateToFollowersScreen(withUrl: followersUrl)
    }
}
