//
//  FavoritedPictureCell.swift
//  TestPicsumApp
//
//  Created by Давид Михайлов on 24.12.2020.
//  Copyright © 2020 Давид Михайлов. All rights reserved.
//

import UIKit

final class FavoritedPictureCell: UITableViewCell {
    
    let picsumService: PicsumService = .init()
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
    }
    
    func getStoredPicture(picId: Int) {
        if let image = picsumService.getFavoritedImage(picId: picId) {
            cellImageView.image = image
        }
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil
    }
    
}

