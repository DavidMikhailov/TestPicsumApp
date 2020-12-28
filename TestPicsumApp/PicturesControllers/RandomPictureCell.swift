//
//  RandomPictureCell.swift
//  TestPicsumApp
//
//  Created by Давид Михайлов on 24.12.2020.
//  Copyright © 2020 Давид Михайлов. All rights reserved.
//

import UIKit

///
final class RandomPictureCell: UITableViewCell {
    
    let picsumService: PicsumService = .init()
    var currentId: Int = 0
    
    // UI
    let labelView: UILabel = .init(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: UIScreen.main.bounds.width,
                                                 height: UIScreen.main.bounds.width))
    let loadingView: UIActivityIndicatorView = .init(style: .large)
    let cellImageView: UIImageView = .init(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: UIScreen.main.bounds.width,
                                                         height: UIScreen.main.bounds.width))
    
    // Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(cellImageView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)
        centerConstraints(loadingView)
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        // invalidate
        labelView.removeFromSuperview()
        cellImageView.image = nil
        currentId = 0
    }
    
    // MARK: - API
    
    func loadRandomImage(id: Int) {
        showLoading()
        currentId = id
        picsumService.getImage(id: id) { picId, image, errorString in
            DispatchQueue.main.async {
                if let errorString = errorString {
                    self.showError(error: errorString)
                    return
                }
                
                self.cellImageView.image = image
            
                // Hide Loading
                self.hideLoading()
                
                // Add Fave gesture
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped))
                tap.numberOfTapsRequired = 2
                self.addGestureRecognizer(tap)
            }
        }
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    func showLoading() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    func showError(error: String) {
        self.hideLoading()
        self.backgroundColor = .gray
        self.labelView.text = error
        self.labelView.textAlignment = .center
        self.addSubview(self.labelView)
        self.centerConstraints(self.labelView)
        print(error)
    }
    
    func centerConstraints(_ uiView: UIView) {
        uiView.centerXAnchor.constraint(greaterThanOrEqualTo: self.centerXAnchor).isActive = true
        uiView.centerYAnchor.constraint(greaterThanOrEqualTo: self.centerYAnchor).isActive = true
    }
    
    @objc func doubleTapped() {
        // do something here
        if let image = cellImageView.image {
            self.picsumService.storeFavorited(picId: currentId, image: image)
            NotificationCenter.default.post(name: .addedToFavorite, object: nil)
        }
    }
    
}
