//
//  SearchModel.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/22.
//

import Foundation

struct SearchModel: Codable {
    var icons: [Icon]
}

struct Icon: Codable {
    var commonName: String
    var platform: String
}
