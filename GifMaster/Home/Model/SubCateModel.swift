//
//  SubCateModel.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/22.
//

import Foundation

struct SubCateModel: Codable {
    var docs: [SubCate]
}

struct SubCate: Codable {
    var platform: String
    var platformName: String
    var commonName: String
    var subcategoryName: String
}
