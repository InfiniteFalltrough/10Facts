//
//  ContentView.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 7/14/23.
//

import SwiftUI
import OpenAIKit

struct ContentView: View {
    
    @State private var result = ""
    
    var star: Star = Star.BlackHole
    
    var body: some View {
        ScrollView(.vertical) {
            Circle()
                .fill(
                    RadialGradient(gradient: Gradient(colors: [.red, .yellow]), center: .center, startRadius: 45, endRadius: 90)
                )
                .frame(width: 180, height: 180)
            
            Text(result).animation(Animation.easeInOut(duration: 1.5))
                .padding(.all)
                .foregroundColor(.white)
            
        }.frame(width: width)
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .black.opacity(0.95), .black]), startPoint: .top, endPoint: .bottom)
        )

        .onAppear {
            Task {
                let openAI = OpenAIKit(apiToken: openAI_token)
                let res = await openAI.sendCompletion(prompt: "tell me 10 random facts about \(star.rawValue)", model: .gptV3_5(.davinciText003), maxTokens: 2048)
                switch res {
                case .success(let aiResult):
                    if let text = aiResult.choices.first?.text {
                        result = text
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
