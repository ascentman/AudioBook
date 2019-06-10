//
//  SearchViewAnimatable.swift
//  AudioBook
//
//  Created by user on 6/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol SearchViewAnimatable: class {}

extension SearchViewAnimatable where Self: UIViewController {

    func showSearchBar(searchBar: UISearchBar) {
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setRightBarButton(nil, animated: true)

        UIView.animate(withDuration: 0.5, animations: {
            searchBar.alpha = 1
        }, completion: { finished in
            searchBar.becomeFirstResponder()
        })
    }

    func hideSearchBar( searchBarButtonItem : UIBarButtonItem) {
        navigationItem.setRightBarButton(searchBarButtonItem, animated: true)

        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
    }
}
