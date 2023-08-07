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
    @State private var validated = true
    
    @State var player = AVPlayer()
    @State var isPlaying: Bool = false
    
    @State private var loading_pos = -110.0
    
    
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack(spacing: 30) {
                    Text("Select at least one planet orbit to plot:")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.blue)
                        .bold()
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
                }
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 1.0)
                                .opacity(0.1))
                .cornerRadius(20)
                
                    
                Button(action: {
                    let options_array = [mercuryOn, venusOn, earthOn, marsOn, jupiterOn, saturnOn, uranusOn, neptuneOn, plutoOn]
                    var one_chosen = false
                    for option in options_array {
                        one_chosen = one_chosen || option
                    }
                    
                    if one_chosen == false {
                        validated = false
                    } else {
                        validated = true
                        state.getInnerSolarSystemOrbits(options: options_array)
                    }
                }, label: {
                    Text("Generate Solar System Plot")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(state.buttonDisabled ?  Color(red: 0.5, green: 0.75, blue: 1.0) : Color(red: 0, green: 0.5, blue: 1.0, opacity: 0.75))
                        .cornerRadius(10)
                        .shadow(radius: state.buttonDisabled ? 0 : 10)
                })
                .disabled(state.buttonDisabled)
                
                Divider()
                    .frame(height: 2)
                    .overlay(Color(red: 0, green: 0.5, blue: 1.0)
                                .opacity(0.1))
                
                if validated == false {
                    Text("You must pick at least one planet to plot.")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.blue)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                } else if state.isLoading {
                    LoadingView()
                    Text("This may take a few seconds...")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.blue)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
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
