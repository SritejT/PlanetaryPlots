//
//  PlotOrbitsView.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import SwiftUI
import AVKit


struct PlotOrbitsView: View {
    @StateObject private var state = PlotOrbitsStateController()
    
    @State private var mercuryOn: Bool = false
    @State private var venusOn: Bool = false
    @State private var earthOn: Bool = false
    @State private var marsOn: Bool = false
    @State private var jupiterOn: Bool = false
    @State private var saturnOn: Bool = false
    @State private var uranusOn: Bool = false
    @State private var neptuneOn: Bool = false
    @State private var plutoOn: Bool = false
    
    @State var player = AVPlayer()
    @State var isPlaying: Bool = false
    
    @State private var loading_pos = -110.0
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                HStack(spacing: 20) {
                    VStack {
                        CheckboxToggle(label: "Mercury", isOn: $mercuryOn)
                        CheckboxToggle(label: "Venus", isOn: $venusOn)
                        CheckboxToggle(label: "Earth", isOn: $earthOn)
                        CheckboxToggle(label: "Mars", isOn: $marsOn)
                        CheckboxToggle(label: "Jupiter", isOn: $jupiterOn)
                    }
                    
                    VStack {
                        CheckboxToggle(label: "Saturn", isOn: $saturnOn)
                        CheckboxToggle(label: "Uranus", isOn: $uranusOn)
                        CheckboxToggle(label: "Neptune", isOn: $neptuneOn)
                        CheckboxToggle(label: "Pluto", isOn: $plutoOn)
                    }
                }
                .padding()
                .background(Color(red: 0, green: 0.50, blue: 1)
                                .opacity(0.75))
                .cornerRadius(20)
                    
                Button(action: {
                    let options_array = [mercuryOn, venusOn, earthOn, marsOn, jupiterOn, saturnOn, uranusOn, neptuneOn, plutoOn]
                    state.getInnerSolarSystemOrbits(options: options_array)
                }, label: {
                    Text("Generate Solar System Plot")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            Color.blue
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        )
                })
                
                Divider()
                
                if state.isLoading {

                    ZStack {
                        Text("Loading...")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .offset(x: 0, y: -25)
             
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(.systemGray5), lineWidth: 3)
                            .frame(width: 250, height: 3)
             
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.blue, lineWidth: 3)
                            .frame(width: 30, height: 3)
                            .offset(x: loading_pos, y: 0)

                    }
                    .onAppear {
                        loading_pos = -110
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            loading_pos = 110
                        }
                    }
                    
                } else if state.encodedImage != "" {
                    
                    GIFView(base64: state.encodedImage)
                        .frame(width: 400.0, height: 400.0, alignment: .center)
                    
                }
            }
        }
    }
}

struct PlotOrbitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlotOrbitsView()
    }
}
