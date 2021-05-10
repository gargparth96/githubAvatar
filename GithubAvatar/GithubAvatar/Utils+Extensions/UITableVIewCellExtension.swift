//
//  UITableVIewCellExtension.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        if Bundle(for: self).path(forResource: reuseIdentifier, ofType: "nib") != nil {
            return UINib(nibName: reuseIdentifier, bundle: Bundle(for: self))
        } else {
            return nil
        }
    }
}
