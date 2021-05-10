//
//  HomeViewController.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var searchedResultsTableView: UITableView!

    private var homeScreenViewModel: HomeScreenViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel = HomeScreenViewModel(self)
        initialiseTableView()
    }

    private func initialiseTableView() {
        searchedResultsTableView.isHidden = true
        searchedResultsTableView.dataSource = homeScreenViewModel
        searchedResultsTableView.delegate = homeScreenViewModel
    }
}


extension HomeViewController: ScreenUpdatable {
    func reloadForSearchSuccessState(_ state: ResponseState) {

    }
}
