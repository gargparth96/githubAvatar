//
//  HomeViewController.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var inputIdtextField: UITextField!
    @IBOutlet private weak var searchedResultsTableView: UITableView!

    private var homeScreenViewModel: HomeScreenViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel = HomeScreenViewModel(self)
        initialiseTableView()
    }

    private func initialiseTableView() {
        searchedResultsTableView.isHidden = true
        searchedResultsTableView.register(UserDetailsTableViewCell.nib,
                                          forCellReuseIdentifier: UserDetailsTableViewCell.reuseIdentifier)
        homeScreenViewModel?.assignTableViewManager(searchedResultsTableView)
    }

    @IBAction private func searchButtonTapped(_ sender: Any) {
        homeScreenViewModel?.handleSearchAction(forQueryString: inputIdtextField.text)
    }

    private func configureScreen(forErrorRecieved recieved: Bool) {
        searchedResultsTableView.isHidden = recieved
        if recieved {
            showErrorPrompt()
        }
    }

    private func showErrorPrompt() {
        let title = "Searched user not found"
        var searchedQuery = "searched user"
        if let inputText = inputIdtextField.text,
           !inputText.isEmpty {
            searchedQuery = inputText
        }
        let message = "Oops! Something went wrong while fetching data for " + searchedQuery

        let errorAlert = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: UIAlertController.Style.alert)

        errorAlert.addAction(UIAlertAction(title: "Okay",
                                           style: UIAlertAction.Style.default,
                                           handler: nil))

        present(errorAlert, animated: true, completion: nil)
    }
}


extension HomeViewController: ScreenUpdatable {
    func reloadForSearchSuccessState(_ state: ResponseState) {
        switch state {
        case .success:
            configureScreen(forErrorRecieved: false)
            searchedResultsTableView.reloadData()
        case .failure:
            configureScreen(forErrorRecieved: true)
        }
    }
}
