//
//  StarModel.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 7/15/23.
//

import Foundation

struct StarModel: Hashable {
    let id: UUID = UUID()
    let title: String
    let facts: String
    let imageURL: String
}
