//
//  AstronautView.swift
//  Moonshot
//
//  Created by Rodrigo Cavalcanti on 07/02/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missionsFormatted: String

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Text("He participated in \(missionsFormatted).")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        var missionImInTemp = [String]()
        
        for mission in allMissions {
            if let match = mission.crew.first(where: { astronaut.id == $0.name }) {
                missionImInTemp.append("\(mission.displayName) as the \(match.role)")
            }
        }
        let missionsFormatted = missionImInTemp.joined(separator: ", ")
        self.missionsFormatted = missionsFormatted
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
