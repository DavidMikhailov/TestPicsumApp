//
//  PicsumImage.swift
//  TestPicsumApp
//
//  Created by Давид Михайлов on 23.12.2020.
//  Copyright © 2020 Давид Михайлов. All rights reserved.
//

import Foundation

struct PicsumImage : Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
