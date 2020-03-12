//
//  HomeViewController.swift
//  AudioBook
//
//  Created by user on 4/21/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, SearchViewAnimatable {

    @IBOutlet var dataProvider: HomeDataProvider!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: CustomSegmentControl!
    @IBOutlet private var searchBarButtonItem: UIBarButtonItem!
    private var searchBar = UISearchBar()

    private enum Constants {
        static let info = "Інформація"
        static let ok = "OK"
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        BookCollectionViewCell.register(for: collectionView)
        collectionView.alwaysBounceVertical = true
        dataProvider.delegate = self
        setupNavigationBar()
        setupSearchBar(searchBar: searchBar)
        setupDefaultsSettings()
        showLastListenedAlert()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showLastListenedAlert),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }

    // MARK: - SearchBar

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    // MARK: - IBActions

    @IBAction func segmentControlClicked(_ sender: CustomSegmentControl) {
        if sender.selectedSegmentIndex == 0 {
            dataProvider.selectedSegment = 0
        } else {
            dataProvider.selectedSegment = 1
        }
        collectionView.reloadData()
    }
    @IBAction func searchClicked(_ sender: Any) {
        showSearchBar(searchBar: searchBar)
    }

    // MARK: - SearchViewAnimatable

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar(searchBarButtonItem: searchBarButtonItem)
    }
    
    // MARK: - Private

    @objc private func showLastListenedAlert() {
        if UserDefaults.standard.historySaving {
            let lastListened = UserDefaults.standard.lastListened
            if !lastListened.isEmpty {
                presentAlert(Constants.info, message: "Ви зупинилися на: \(lastListened)", acceptTitle: Constants.ok, declineTitle: nil)
            }
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    private func setupDefaultsSettings() {
        if !UserDefaults.standard.isRewindTimePresentInUserDefaults() {
            UserDefaults.standard.updateRewindTime(10.0)
        }

        if !UserDefaults.standard.isSpeedPresentInUserDefaults() {
            UserDefaults.standard.updateSpeed(1.0)
        }

        if !UserDefaults.standard.isAutoPlayPresentInUserDefaults() {
            UserDefaults.standard.updateAutoPlay(true)
        }
    }

    private func setupSearchBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Відмінити"
        searchBar.showsCancelButton = true
        searchBar.barTintColor = .white
        searchBar.returnKeyType = UIReturnKeyType.done
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        searchBarButtonItem = navigationItem.rightBarButtonItem
    }
}

// MARK: - Extensions

extension HomeViewController: HomeDataProviderDelegate {

    // MARK: - HomeDataProviderDelegate

    func goToDetails(_ selectedSegment: Int, index: Int) {
        navigationItem.titleView = nil
        hideSearchBar(searchBarButtonItem: searchBarButtonItem)
        collectionView.reloadData()

        let storyboard = UIStoryboard(name: StoryboardName.details, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailsViewController.description()) as? DetailsViewController
        if selectedSegment == 0 {
            if !dataProvider.isSearchBarEmpty {
                viewController?.title = dataProvider.filteredNewTestament[index].name
                viewController?.dataProvider.fillChosen(book: dataProvider.filteredNewTestament[index])
            } else {
                viewController?.title = dataProvider.dataManager.newTestament[index].name
                viewController?.dataProvider.fillChosen(book: dataProvider.dataManager.newTestament[index])
            }
        } else {
            if !dataProvider.isSearchBarEmpty {
                viewController?.title = dataProvider.filteredOldTestament[index].name
                viewController?.dataProvider.fillChosen(book: dataProvider.filteredOldTestament[index])
            } else {
                viewController?.title = dataProvider.dataManager.oldTestament[index].name
                viewController?.dataProvider.fillChosen(book: dataProvider.dataManager.oldTestament[index])
            }
        }
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataProvider.isSearchBarEmpty = searchBar.text?.isEmpty ?? true
        dataProvider.filterBookForSearchedText(searchText) {
            collectionView.reloadData()
        }
    }
}
