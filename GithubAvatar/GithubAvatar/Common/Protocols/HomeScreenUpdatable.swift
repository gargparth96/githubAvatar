//
//  HomeScreenUpdatable.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

enum ResponseState {
    case success
    case failure
}

protocol ScreenUpdatable: class {
    func reloadForSearchSuccessState(_ state: ResponseState)
}
