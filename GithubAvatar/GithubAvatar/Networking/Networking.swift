//
//  Networking.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

typealias SearchQueryResponse = ((_ response: SearchResponse?, _ error: Error?) -> Void)
typealias FollowersResponse = ((_ response: [UserDetails]?, _ error: Error?) -> Void)

class Networking {

    static let sharedInstance = Networking()

    private init() { }

    func getUsersMatchingSearchedQuery(_ query: String, _ completion: SearchQueryResponse) {

    }

    func getFollowersForUser(usingUrl followersUrl: String, _ completion: FollowersResponse) {

    }
}
