//
//  RelativeOrbitsView.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import SwiftUI

struct RelativeOrbitsView: View {
    
    enum Planets: String, CaseIterable, Identifiable {
        case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        var id: Self { self }
    }
    
    
    let semiMajorAxes = [
        "Mercury": "0.387",
        "Venus": "0.723",
        "Earth": "1.000",
        "Mars": "1.523",
        "Jupiter": "5.202",
        "Saturn": "9.576",
        "Uranus": "19.293",
        "Neptune": "30.246",
        "Pluto": "39.509"
    ]
    
    let orbitalPeriods = [
        "Mercury": "0.241",
        "Venus": "0.615",
        "Earth": "1.000",
        "Mars": "1.881",
        "Jupiter": "11.861",
        "Saturn": "29.628",
        "Uranus": "84.747",
        "Neptune": "166.344",
        "Pluto": "248.348"
    ]
    
    let eccentricities = [
        "Mercury": "0.21",
        "Venus": "0.01",
        "Earth": "0.02",
        "Mars": "0.09",
        "Jupiter": "0.05",
        "Saturn": "0.06",
        "Uranus": "0.05",
        "Neptune": "0.01",
        "Pluto": "0.25"
    ]
    
    
    
    
    @State private var showCustomForm = false
    @State private var semiMajorAxis1: String = "0.387"
    @State private var semiMajorAxis2: String = "0.387"
    @State private var orbitalPeriod1: String = "0.241"
    @State private var orbitalPeriod2: String = "0.241"
    @State private var eccentricity1: String = "0.21"
    @State private var eccentricity2: String = "0.21"
    
    @State private var planet1: Planets = .Mercury
    @State private var planet2: Planets = .Mercury
    @State private var isLoading = false
    @State private var verified = true
    
    @State private var picker1Disabled = false
    @State private var picker2Disabled = false
    @State private var custom1Disabled = false
    @State private var custom2Disabled = false
    
    
    @State private var loading_pos = -110.0
    @StateObject var state = RelativeOrbitsStateController()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                    .frame(height: 30)
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        Text("Select stationary planet: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                            .foregroundColor(.white)
                            .frame(maxWidth: 210, alignment: .trailing)
                        Picker("Select stationary planet: ", selection: $planet1) {
                            ForEach(Planets.allCases, id: \.self) { planet in
                                Text(planet.rawValue).tag(planet.rawValue)
                            }
                        }
                        .tint(picker1Disabled ? .gray : .blue)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .onChange(of: planet1) { newPlanet1 in
                            picker1Disabled = false
                            semiMajorAxis1 = semiMajorAxes[newPlanet1.rawValue]!
                            orbitalPeriod1 = orbitalPeriods[newPlanet1.rawValue]!
                            eccentricity1 = eccentricities[newPlanet1.rawValue]!
                            custom1Disabled = true
                        }
                        
                        Button(action: {
                            custom1Disabled = false
                            showCustomForm.toggle()
                            picker1Disabled = true
                        }, label: {
                            Text("Custom Planet")
                                .accentColor(custom1Disabled ? .gray : .blue)
                                .frame(maxWidth: 70, alignment: .center)
                                .padding()
                                .background(.white)
                                .cornerRadius(20)
                                
                        })
                        .sheet(isPresented: $showCustomForm, content: {
                            CustomPlanetFormView(showForm: $showCustomForm, orbitalPeriod: $orbitalPeriod1, semiMajorAxis: $semiMajorAxis1, eccentricity: $eccentricity1)
                        })
                    }
                    
                    .padding()
                    .background(Color(red: 0, green: 0.50, blue: 1)
                                    .opacity(0.75))
                    .cornerRadius(20)
                    
                    
                    HStack(spacing: 10) {
                        Text("Select observed planet: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 210, alignment: .trailing)
                        Picker("Select observed planet: ", selection: $planet2) {
                            ForEach(Planets.allCases) { planet in
                                Text(planet.rawValue)
                            }
                        }
                        .onChange(of: planet2) { newPlanet2 in
                            picker2Disabled = false
                            semiMajorAxis2 = semiMajorAxes[newPlanet2.rawValue]!
                            orbitalPeriod2 = orbitalPeriods[newPlanet2.rawValue]!
                            eccentricity2 = eccentricities[newPlanet2.rawValue]!
                            custom2Disabled = true
                        }
                        .accentColor(picker2Disabled ? .gray : .blue)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        
                        Button(action: {
                            custom2Disabled = false
                            showCustomForm.toggle()
                            picker2Disabled = true
                        }, label: {
                            Text("Custom Planet")
                                .accentColor(custom2Disabled ? .gray : .blue)
                                .frame(maxWidth: 70, alignment: .center)
                                .padding()
                                .background(.white)
                                .cornerRadius(20)
                                
                        })
                        .sheet(isPresented: $showCustomForm, content: {
                            CustomPlanetFormView(showForm: $showCustomForm, orbitalPeriod: $orbitalPeriod2, semiMajorAxis: $semiMajorAxis2, eccentricity: $eccentricity2)
                        })
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.50, blue: 1)
                                    .opacity(0.75))
                    .cornerRadius(20)
                }
                .padding()
                .background(Color(red: 0.9, green: 0.95, blue: 1))
                .cornerRadius(20)
                
                
                Spacer()
                    .frame(height: 0)
                
                Button(action: {
                    if !(semiMajorAxis1 == semiMajorAxis2 && orbitalPeriod1 == orbitalPeriod2 && eccentricity1 == eccentricity2) {
                        verified = true
                        state.getRelativeOrbit(orbitalPeriod1: orbitalPeriod1, semiMajorAxis1: semiMajorAxis1, eccentricity1: eccentricity1, orbitalPeriod2: orbitalPeriod2, semiMajorAxis2: semiMajorAxis2, eccentricity2: eccentricity2)
                    } else {
                        verified = false
                    }
                }, label: {
                    Text("Generate Relative Orbit")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(Color(red: 0, green: 0.50, blue: 1)
                                        .opacity(0.75)
                                        .cornerRadius(10)
                                        .shadow(radius: 10))
                })
                
                Divider()
                    .frame(height: 2)
                    .overlay(Color(red: 0, green: 0.5, blue: 1.0)
                                .opacity(0.1))
                
                if !verified {
                    Text("You cannot pick the same planet twice.")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.blue)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if state.isLoading {
                    ZStack {
                        Text("Loading...")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.blue)
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
                                Color(red: 0, green: 0.50, blue: 1)
                                    .opacity(0.75)
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
