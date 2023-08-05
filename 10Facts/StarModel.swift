//
//  StarModel.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 7/15/23.
//

import Foundation

struct StarModel: Hashable {
    let id = UUID()
    let title: String
    let facts: String
    var imageURL: String? = ""
}
