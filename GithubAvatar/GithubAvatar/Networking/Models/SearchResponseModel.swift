//
//  SearchResponseModel.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

struct SearchResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [UserDetails]?
}

struct UserDetails: Codable {
    let login: String
    let id: Int
    let avatarUrl: String?
    let followersUrl: String?
}

