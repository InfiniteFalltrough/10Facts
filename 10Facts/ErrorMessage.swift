//
//  ErrorMessage.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 8/6/23.
//

import SwiftUI

struct ErrorMessage: Error, Identifiable {
    let id: UUID = UUID()
    let title: String = "Error"
    var message: String = "Error message..."
}
