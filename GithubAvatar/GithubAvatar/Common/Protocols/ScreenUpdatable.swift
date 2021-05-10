//
//  ScreenUpdatable.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

/*
 Using a combination of the following enum and protocol
 to reload the screens depending on the api response
 */

enum ResponseState {
    case success
    case failure
}

protocol ScreenUpdatable: class {
    func reloadForSearchSuccessState(_ state: ResponseState)
}
