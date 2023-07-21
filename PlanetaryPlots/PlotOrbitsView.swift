//
//  PlotOrbitsView.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import SwiftUI


struct PlotOrbitsView: View {
    @StateObject private var state = PlotOrbitsStateController()
    
    @State private var mercuryOn: Bool = true
    @State private var venusOn: Bool = true
    @State private var earthOn: Bool = true
    @State private var marsOn: Bool = true
    @State private var jupiterOn: Bool = true
    @State private var saturnOn: Bool = true
    @State private var uranusOn: Bool = true
    @State private var neptuneOn: Bool = true
    @State private var plutoOn: Bool = true
    
    
    var body: some View {
        VStack(spacing: 50) {
            HStack(spacing: 30) {
                VStack {
                    Toggle("Mercury", isOn: $mercuryOn)
                    Toggle("Venus", isOn: $venusOn)
                    Toggle("Earth", isOn: $earthOn)
                    Toggle("Mars", isOn: $marsOn)
                    Toggle("Jupiter", isOn: $jupiterOn)
                    Toggle("Saturn", isOn: $saturnOn)
                    Toggle("Uranus", isOn: $uranusOn)
                    Toggle("Neptune", isOn: $neptuneOn)
                    Toggle("Pluto", isOn: $plutoOn)
                }
                Spacer()
                Button("Generate Solar System Plot") {
                    state.getInnerSolarSystemOrbits()
                }
            }.padding()
            let decodedImage = Data(base64Encoded: state.encodedImage)!
            let image = (UIImage(data: decodedImage) ?? UIImage(systemName: "questionmark.folder.fill"))
        
            Image(uiImage: image!)
                .resizable()
                .frame(width: 200.0, height: 200.0)
                .scaledToFit()
        }
    }
}

struct PlotOrbitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlotOrbitsView()
    }
}
