//
//  HomeScreenUpdatable.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

enum SearchState {
    case success
    case failure
}

protocol HomeScreenUpdatable: class {
    func reloadForSearchSuccessState(_ state: SearchState)
}
