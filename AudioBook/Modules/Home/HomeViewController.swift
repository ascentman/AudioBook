//
//  HomeViewController.swift
//  AudioBook
//
//  Created by user on 4/21/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet var dataProvider: HomeDataProvider!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: CustomSegmentControl!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        BookCollectionViewCell.register(for: collectionView)
        dataProvider.delegate = self
        setupNavigationBar()
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

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

// MARK: - Extensions

extension HomeViewController: HomeDataProviderDelegate {

    // MARK: - HomeDataProviderDelegate

    func goToDetails(_ selectedSegment: Int, index: Int) {
        let storyboard = UIStoryboard(name: StoryboardName.details, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailsViewController.description()) as? DetailsViewController
        if selectedSegment == 0 {
            viewController?.title = dataProvider.dataManager.newTestament[index].name
            viewController?.dataProvider.fillChosen(book: dataProvider.dataManager.newTestament[index])
        } else {
            viewController?.title = dataProvider.dataManager.oldTestament[index].name
            viewController?.dataProvider.fillChosen(book: dataProvider.dataManager.oldTestament[index])
        }
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
