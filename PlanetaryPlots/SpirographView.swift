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
    
    
    @State private var planet1: Planets = .Mercury
    @State private var planet2: Planets = .Mercury
    @State private var isLoading = false
    @State private var loading_id = 0
    @State private var verified = true
    
    @State private var loading_pos = -110.0
    @StateObject var state = SpirographStateController()
    
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
                            .frame(maxWidth: 150, alignment: .trailing)
                        Picker("Select 1st planet: ", selection: $planet1) {
                            ForEach(Planets.allCases) { planet in
                                Text(planet.rawValue)
    
                            }
                        }
                        .accentColor(.blue)
                        .padding()
                        .background(Color(red: 0.9, green: 0.95, blue: 1))
                        .cornerRadius(20)
                        

                    }
                    .padding()
                    .background(Color(red: 0, green: 0.50, blue: 1)
                                    .opacity(0.75))
                    .cornerRadius(20)
                    
                    
                    HStack(spacing: 10) {
                        Text("Select 2nd planet:  ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 150, alignment: .trailing)
                        Picker("Select 2nd  planet: ", selection: $planet2) {
                            ForEach(Planets.allCases) { planet in
                                Text(planet.rawValue)
                            }
                        }
                        .accentColor(.blue)
                        .padding()
                        .background(Color(red: 0.9, green: 0.95, blue: 1))
                        .cornerRadius(20)
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
                    if planet1 != planet2 {
                        verified = true
                        state.getSpirograph(planet1: planet1.rawValue, planet2: planet2.rawValue)
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
                        .background(
                            Color(red: 0, green: 0.50, blue: 1)
                                .opacity(0.75)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        )
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
                        Text("Save Spirograph")
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
