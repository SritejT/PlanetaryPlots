//
//  RelativeOrbitsView.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import SwiftUI

struct RelativeOrbitsView: View {
    
    @StateObject var state = RelativeOrbitsStateController()
    
    enum Planets: String, CaseIterable, Identifiable {
        case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        var id: Self { self }
    }
    
    
    @State private var planet1: Planets = .Mercury
    @State private var planet2: Planets = .Mercury
    @State private var isLoading = false
    @State private var loading_id = 0
    
    @State private var loading_pos = -110.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                    .frame(height: 30)
                HStack(spacing: 10) {
                    Text("Select stationary planet: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Picker("Select stationary planet: ", selection: $planet1) {
                        ForEach(Planets.allCases) { planet in
                            Text(planet.rawValue)
                        }
                    }
                    .accentColor(.white)
                }
                .padding()
                .background(
                    Color.blue
                        .cornerRadius(10)
                )
                
                HStack(spacing: 10) {
                    Text("Select observed planet: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Picker("Select observed planet: ", selection: $planet2) {
                        ForEach(Planets.allCases) { planet in
                            Text(planet.rawValue)
                        }
                    }
                    .accentColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                
                Spacer()
                    .frame(height: 0)
                
                Button(action: {
                    state.getRelativeOrbit(planet1: planet1.rawValue, planet2: planet2.rawValue)
                }, label: {
                    Text("Generate Relative Orbit")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            Color(red: 0.0, green: 0.1, blue: 1.0)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        )
                })
                
                Divider()
                
                if state.isLoading {
                    Spacer()
                        .frame(height: 160)
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
                    let decodedImage = Data(base64Encoded: state.encodedImage) ?? Data()
                    let image = (UIImage(data: decodedImage) ?? UIImage(systemName: "questionmark.folder.fill"))
                
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 400.0, height: 400.0)
                        .scaledToFit()
                    
                    Button(action: {
                        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    }, label: {
                        Text("Save Relative Orbit")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 20)
                            .background(
                                Color(red: 0.0, green: 0.1, blue: 1.0)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            )
                    })
                }
            }
            .pickerStyle(.menu)
        }
    }
}


struct RelativeOrbitsView_Previews: PreviewProvider {
    static var previews: some View {
        RelativeOrbitsView()
    }
}
