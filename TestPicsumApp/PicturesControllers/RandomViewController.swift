//
//  SecondViewController.swift
//  TestPicsumApp
//
//  Created by Давид Михайлов on 25.12.2020.
//  Copyright © 2020 Давид Михайлов. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {

    var items: [Int] = []
    var cellId = "itemCell"
    var isLoading = false

    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random"

        setupData()
        setupTable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedToFavorite(_:)), name: .addedToFavorite, object: nil)
    }
    
    func setupData() {
        // Skeleton
        for _ in 1...1000 {
            items.append(Int.random(in: 1...1000))
        }
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RandomPictureCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 420

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }

    @objc func onAddedToFavorite(_ notification: Notification) {
        showSuccessPopup()
    }
    
    func showSuccessPopup() {
        let alert = UIAlertController(title: "Success", message: "Added to Favorites", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true, completion: nil)
        }
    }

}

extension RandomViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let randomPictureCell = cell as? RandomPictureCell {
            randomPictureCell.loadRandomImage(id: items[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
}
