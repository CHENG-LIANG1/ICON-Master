//
//  CateModel.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/21.
//

import UIKit

struct iconData: Codable {
    var docs: [iconCateModel]
}

struct iconCateModel: Codable {
    var name: String
    var apiCode: String
    var subcategories: [subcategory]
}

struct subcategory: Codable {
    var name: String
}
