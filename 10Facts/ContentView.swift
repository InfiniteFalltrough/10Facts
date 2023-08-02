//
//  ContentView.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 7/14/23.
//

import SwiftUI
import OpenAIKit

struct ContentView: View {
    
    @State private var imgUrl = ""
    @State private var facts = ""
    
    @ObservedObject var manager: Manager = Manager()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                AsyncImage(url: URL(string: manager.result.first?.imageURL ?? ""))
                    .frame(width: width, height: height / 2.25)
                Text(manager.result.first?.facts ?? "").animation(Animation.easeInOut(duration: 1))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                    .foregroundColor(.white)
                Spacer()
            }
            .onAppear {
                manager.requestData()
            }
        }.frame(width: width)
            .background(
                LinearGradient(gradient: Gradient(colors: [.black.opacity(0.95), .black.opacity(0.90), .black.opacity(0.95)]), startPoint: .top, endPoint: .bottom)
            )
    }
    
}
