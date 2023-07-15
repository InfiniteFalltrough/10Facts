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
    let openAI = OpenAIKit(apiToken: openAI_token)
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                AsyncImage(url: URL(string: imgUrl))
                    .frame(width: width, height: height / 2.25)
                Text(facts).animation(Animation.easeInOut(duration: 1))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                    .foregroundColor(.white)
                Spacer()
            }
            .onAppear {
                requestAI(star: Star.Moon)
            }
        }.frame(width: width)
            .background(
                LinearGradient(gradient: Gradient(colors: [.black.opacity(0.95), .black.opacity(0.90), .black.opacity(0.95)]), startPoint: .top, endPoint: .bottom)
            )
    }
    
    func requestAI(star: Star) {
        Task {
            await sendRequest(star: star)
            await requestImage(star: star)
        }
    }
    
    private func sendRequest(star: Star) async {
        let res = await openAI.sendCompletion(prompt: "tell me 10 random facts about \(star.rawValue)", model: .gptV3_5(.davinciText003), maxTokens: 2048)
        switch res {
        case .success(let aiResult):
            if let text = aiResult.choices.first?.text {
                facts = text
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func requestImage(star: Star) async {
        openAI.sendImagesRequest(prompt: "space, image of the \(star)", size: .size512, n: 1) { res in
            switch res {
            case .success(let aiResult):
                DispatchQueue.main.async {
                    if let urlString = aiResult.data.first?.url {
                        imgUrl = urlString
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
