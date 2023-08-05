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
    
    @State private var selectedImageIndex: Int = 0
    
    @ObservedObject var manager: Manager
    
    var body: some View {
        TabView {
            ForEach(manager.result, id: \.self) { s in
                ScrollView(.vertical) {
                    AsyncImage(url: URL(string: s.imageURL  ?? ""))
                        .frame(width: width, height: height / 2.25)
                    Text(s.title).foregroundColor(.white)
                    Text(s.facts).animation(Animation.easeInOut(duration: 1))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
        .background(backgroud())
    }
    
    func backgroud() -> some View {
        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.95), .black.opacity(0.90), .black.opacity(0.95)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
    }
    
}
