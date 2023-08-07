//
//  CustomPlanetFormView2.swift
//  PlanetaryPlots
//
//  Created by Sritej Tummuru on 04/08/2023.
//

import SwiftUI

struct CustomPlanetFormView2: View {
    
    @Binding var showForm: Bool
    
    @Binding var orbitalPeriod: String
    @Binding var semiMajorAxis: String
    @Binding var eccentricity: String
    
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    Text("Orbital Period (years)")
                        .font(.headline)
                        .foregroundColor(.white)
                    TextField("Enter orbital period", text: $orbitalPeriod, onEditingChanged: { editing in
                        if !editing {
                            semiMajorAxis = String(ceil(pow(Double(orbitalPeriod)!, 0.67) * 1000)/1000.0)
                        }
                    })
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 300, alignment: .center)
                }
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 1, opacity: 0.75))
                .cornerRadius(20)
                    
                VStack(spacing: 20) {
                    Text("Semi-Major Axis (AU)")
                        .font(.headline)
                        .foregroundColor(.white)
                    TextField("Enter semi-major axis", text: $semiMajorAxis, onEditingChanged: { editing in
                        if !editing {
                            orbitalPeriod = String(ceil(pow(Double(semiMajorAxis)!, 1.5) * 1000)/1000.0)
                        }
                    })
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 300, alignment: .center)
                }
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 1, opacity: 0.75))
                .cornerRadius(20)
                    
                VStack(spacing: 20) {
                    Text("Eccentricity")
                        .font(.headline)
                        .foregroundColor(.white)
                    TextField("Enter eccentricity", text: $eccentricity)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 300, alignment: .center)
                        
                }
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 1, opacity: 0.75))
                .cornerRadius(20)
            }
            .padding()
            .background(Color(red: 0.9, green: 0.95, blue: 1))
            .cornerRadius(20)
            
            Button(action: {
                if let a = Double(orbitalPeriod) {
                    if let b = Double(semiMajorAxis) {
                        if let c = Double(eccentricity) {
                            if c < 1 && c >= 0  {
                                showForm = false
                            } else {
                                errorMessage = "The eccentricity has to be between 0 and 1"
                            }
                        } else {
                            errorMessage = "The eccentricity has to be a decimal number."
                        }
                    } else {
                        errorMessage = "The semi-major axis has to be a decimal number."
                    }
                } else {
                    errorMessage = "The orbital period has to be a decimal number."
                }
    
            }, label: {
                Text("Submit")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 0, green: 0.5, blue: 1, opacity: 0.75))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    
            })
            
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(Color(red: 0, green: 0.5, blue: 1, opacity: 0.75))
        }

    }
}

