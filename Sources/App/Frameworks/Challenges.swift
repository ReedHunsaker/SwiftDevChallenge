//
//  Challenges.swift
//  DevChallenge
//
//  Created by Reed hunsaker on 1/14/25.
//

import Foundation
import Vapor

class Challenges {
    
    @MainActor static let shared = Challenges()
    
    var frameworks = [String: [Framework]]()
    
    var frameworkCount: Int = 0
    
    func load() throws {
        let directory = DirectoryConfiguration.detect()
        let url = URL(fileURLWithPath: directory.workingDirectory)
            .appendingPathComponent("frameworks.json", isDirectory: false)
        
        let data = try Data(contentsOf: url)
        
        frameworks = try JSONDecoder().decode([String: [Framework]].self, from: data)
        
        frameworkCount = frameworks.values.map(\.count).reduce(0, +)
    }
    
    func random(n: Int) -> [Framework] {
        var challengeFrameworks: [Framework] = []
        var keys = Array(frameworks.keys)
        let amount = n <= frameworkCount ? n : frameworkCount
        for _ in 0..<amount {
            let randomKey = String(keys.randomElement()?.first ?? "-")
            let frameworksForKey = frameworks[randomKey]
            if let framework = frameworksForKey?.randomElement() {
                challengeFrameworks.append(framework)
            }
            keys = keys.filter { $0 != randomKey }
        }
        return challengeFrameworks
    }
}
