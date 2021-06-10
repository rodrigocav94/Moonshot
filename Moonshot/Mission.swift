//
//  Mission.swift
//  Moonshot
//
//  Created by Rodrigo Cavalcanti on 05/02/21.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    var formattedCrew: String {
        let allAstronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        var names = [String]()
        for member in crew {
            if let match = allAstronauts.first(where: {$0.id == member.name}) {
                names.append(match.name)
            }
        }
        return names.joined(separator: ", ")
    }
}
