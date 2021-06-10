//
//  ContentView.swift
//  Moonshot
//
//  Created by Rodrigo Cavalcanti on 03/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingCrew = false
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, allAstronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(showingCrew ? mission.formattedCrew : mission.formattedLaunchDate)
                            .font(.footnote)
                            .lineLimit(1)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle("Show Crew", isOn: $showingCrew)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
