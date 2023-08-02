//
//  Manager.swift
//  10Facts
//
//  Created by Viktor Golubenkov on 7/15/23.
//

import SwiftUI
import OpenAIKit

class Manager: ObservableObject {
    
    static let shared: Manager = Manager()
    
    private let openAI = OpenAIKit(apiToken: openAI_token)
    private let stars: [String] = ["Sun", "Moon", "Black Hole"]
    
    @Published var result: [StarModel] = []
    
    func requestData() {
        stars.forEach { s in
            Task {
                let data = await sendRequest(star: s)
                DispatchQueue.main.async {
                    self.result.append(data)
                }
            }
        }
    }
    
    private func sendRequest(star: String) async -> StarModel {
        var facts: String = ""
        var imgUrl: String = ""
        let dataRes = await openAI.sendCompletion(prompt: "tell me 10 random facts about \(star)", model: .gptV3_5(.davinciText003), maxTokens: 2048)
        switch dataRes {
        case .success(let res):
            if let text = res.choices.first?.text {
                facts = text
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
        
        let imageRes = await openAI.sendImagesRequest(prompt: "space, image of the \(star)", size: .size512, n: 1)
        switch imageRes {
        case .success(let res):
            if let url = res.data.first?.url {
                imgUrl = url
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
        return StarModel(title: star, facts: facts, imageURL: imgUrl)
    }
    
}
