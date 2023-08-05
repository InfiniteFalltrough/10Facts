//
//  _0FactsApp.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 7/14/23.
//

import SwiftUI

@main
struct _0FactsApp: App {
    
    @StateObject var manager: Manager = Manager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(manager: manager)
                .onAppear {
                    manager.requestData()
                }
        }
    }
}
