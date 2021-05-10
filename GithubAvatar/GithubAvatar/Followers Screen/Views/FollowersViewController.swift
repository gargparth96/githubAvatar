//
//  FollowersViewController.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import UIKit

class FollowersViewController: UIViewController {

    static let identifier = "FollowersViewController"

    @IBOutlet private weak var followersTableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!

    private var viewModel: FollowersScreenViewModel?

    init(_ viewModel: FollowersScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: FollowersViewController.identifier, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        initialiseTableView()
        viewModel?.loadDataOnScreen()
    }

    private func initialiseTableView() {
        followersTableView.isHidden = true
        followersTableView.register(UserDetailsTableViewCell.nib,
                                    forCellReuseIdentifier: UserDetailsTableViewCell.reuseIdentifier)
        viewModel?.assignTableViewManager(followersTableView)
    }


    private func configureScreen(forErrorRecieved recieved: Bool) {
        followersTableView.isHidden = recieved
        errorLabel.isHidden = !recieved
    }
}

extension FollowersViewController: ScreenUpdatable {
    
    func reloadForSearchSuccessState(_ state: ResponseState) {
        switch state {
        case .success:
            configureScreen(forErrorRecieved: false)
            followersTableView.reloadData()
        case .failure:
            configureScreen(forErrorRecieved: true)
        }
    }
}
