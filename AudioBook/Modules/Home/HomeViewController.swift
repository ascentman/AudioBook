//
//  HomeViewController.swift
//  AudioBook
//
//  Created by user on 4/21/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private var dataProvider: HomeDataProvider!
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 24)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

// MARK: - Extensions

extension HomeViewController: HomeDataProviderDelegate {

    // MARK: - HomeDataProviderDelegate

    func goToDetails(_ selectedSegment: Int, index: Int) {
        let storyboard = UIStoryboard(name: StoryboardName.details, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: DetailsViewController.description()) as? DetailsViewController
        if selectedSegment == 0 {
            vc?.fillDetails("\(dataProvider.dataManager.new[index])\(index)")
        } else {
            vc?.fillDetails("\(dataProvider.dataManager.old[index])\(index)")
        }
        if let vc = vc {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
