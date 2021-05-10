//
//  UIImageView.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation
import UIKit

extension UIImageView {

    func setImage(using urlString: String?, andDefaultImage defaultImage: String) {
        guard let urlString = urlString else {
            self.image = UIImage(named: defaultImage)
            return
        }
        Networking.sharedInstance.getRawData(from: urlString) { data, response, error in
            guard let data = data else {
                self.image = UIImage(named: defaultImage)
                return
            }

            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
}
