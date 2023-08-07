//
//  SpirographView.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import SwiftUI

struct SpirographView: View {
    
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
    
    @State var showCustomForm1 = false
    @State var showCustomForm2 = false
    @State var semiMajorAxis1: String = "0.387"
    @State var semiMajorAxis2: String = "0.387"
    @State var orbitalPeriod1: String = "0.241"
    @State var orbitalPeriod2: String = "0.241"
    @State var eccentricity1: String = "0.21"
    @State var eccentricity2: String = "0.21"
    
    @State var planet1: Planets = .Mercury
    @State var planet2: Planets = .Mercury
    @State var isLoading = false
    @State var verified = true
    
    @State var picker1Disabled = false
    @State var picker2Disabled = false
    @State var custom1Disabled = true
    @State var custom2Disabled = true
    
    @State private var loading_pos = -110.0
    @StateObject var state = SpirographStateController()
    
    var progressAnimation: Animation {
        Animation
            .easeInOut(duration: 1)
            .repeatForever(autoreverses: true)
    }
    
    var body: some View {
    ScrollView {
        VStack(spacing: 30) {
            Spacer()
                .frame(height: 30)
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Text("Select 1st planet: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Menu(planet1.rawValue) {
                        ForEach(Planets.allCases) { planet in
                            Button {
                                planet1 = planet
                                picker1Disabled = false
                                semiMajorAxis1 = semiMajorAxes[planet.rawValue]!
                                orbitalPeriod1 = orbitalPeriods[planet.rawValue]!
                                eccentricity1 = eccentricities[planet.rawValue]!

                                custom1Disabled = true
                            } label: {
                                Text(planet.rawValue)
                            }
                        }
                    }
                    .frame(minWidth: 80)
                    .foregroundColor(picker1Disabled ? .gray : .blue)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    
                    
                        
                    Button(action: {
                        custom1Disabled = false
                        showCustomForm1 = true
                        picker1Disabled = true
                    }, label: {
                        Text("Custom Planet")
                            .frame(minWidth: 70, alignment: .center)
                            .foregroundColor(custom1Disabled ? .gray : .blue)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            
                    })
                    .sheet(isPresented: $showCustomForm1, content: {
                        CustomPlanetFormView1(showForm: $showCustomForm1, orbitalPeriod: $orbitalPeriod1, semiMajorAxis: $semiMajorAxis1, eccentricity: $eccentricity1)
                        .interactiveDismissDisabled()
                    })

                }
                .padding()
                .background(Color(red: 0, green: 0.50, blue: 1)
                                .opacity(0.75))
                .cornerRadius(20)
                
                
                HStack(spacing: 10) {
                    Text("Select 2nd planet: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        // .frame(maxWidth: 150, alignment: .leading)
                    
                    Menu(planet2.rawValue) {
                        ForEach(Planets.allCases) { planet in
                            Button {
                                planet2 = planet
                                picker2Disabled = false
                                semiMajorAxis2 = semiMajorAxes[planet.rawValue]!
                                orbitalPeriod2 = orbitalPeriods[planet.rawValue]!
                                eccentricity2 = eccentricities[planet.rawValue]!
                                custom2Disabled = true
                            } label: {
                                Text(planet.rawValue)
                            }
                        }
                    }
                    .frame(minWidth: 80)
                    .foregroundColor(picker2Disabled ? .gray : .blue)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    
                    Button(action: {
                        custom2Disabled = false
                        showCustomForm2 = true
                        picker2Disabled = true
                    }, label: {
                        Text("Custom Planet")
                            .frame(minWidth: 70, alignment: .center)
                            .foregroundColor(custom2Disabled ? .gray : .blue)
                            
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            
                    })
                    .sheet(isPresented: $showCustomForm2, content: {
                        CustomPlanetFormView2(showForm: $showCustomForm2, orbitalPeriod: $orbitalPeriod2, semiMajorAxis: $semiMajorAxis2, eccentricity: $eccentricity2)
                        .interactiveDismissDisabled()
                    })
                }
                .padding()
                .background(Color(red: 0, green: 0.50, blue: 1)
                                .opacity(0.75))
                .cornerRadius(20)
            }
            .padding()
            .background(Color(red: 0, green: 0.50, blue: 1)
                            .opacity(0.1))
            .cornerRadius(20)
            
            Spacer()
                .frame(height: 0)
            
            Button(action: {
                if !(semiMajorAxis1 == semiMajorAxis2 && orbitalPeriod1 == orbitalPeriod2 && eccentricity1 == eccentricity2) {
                    verified = true
                    state.getSpirograph(orbitalPeriod1: orbitalPeriod1, semiMajorAxis1: semiMajorAxis1, eccentricity1: eccentricity1, orbitalPeriod2: orbitalPeriod2, semiMajorAxis2: semiMajorAxis2, eccentricity2: eccentricity2)
                } else {
                    verified = false
                }
            }, label: {
                Text("Generate Spirograph")
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
            
            if !verified {
                Text("You cannot pick the same planet twice.")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.blue)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if state.isLoading {
                LoadingView()
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
                    Text("Save Spirograph to Photos")
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

struct SpirographView_Previews: PreviewProvider {
    static var previews: some View {
        SpirographView()
    }
}
