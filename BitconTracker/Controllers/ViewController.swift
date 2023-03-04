//
//  ViewController.swift
//  BitconTracker
//
//  Created by Димаш Алтынбек on 02.03.2023.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -Views-

    let viewsElements = ViewsElements()
    
    //MARK: -Life cycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    //MARK: -Functions-
    private func setUpViews() {
        view.addSubview(viewsElements)
        viewsElements.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewsElements.topAnchor.constraint(equalTo: view.topAnchor),
            viewsElements.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewsElements.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewsElements.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}

