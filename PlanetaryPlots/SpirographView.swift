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
    
    

    @State var planet1: Planets = .Mercury
    @State var planet2: Planets = .Mercury
    @State private var isLoading = false
    
    
    
    @StateObject var state = SpirographStateController()
    
    var body: some View {
        VStack(spacing: 50) {
            HStack(spacing: 10) {
                Text("Select 1st planet for spirograph:")
                Picker("Select 1st planet for spirograph", selection: $planet1) {
                    ForEach(Planets.allCases) { planet in
                        Text(planet.rawValue)
                    }
                }
            }
            HStack(spacing: 10) {
                Text("Select 2nd planet for spirograph:")
                Picker("Select 2nd planet for spirograph", selection: $planet2) {
                    ForEach(Planets.allCases) { planet in
                        Text(planet.rawValue)
                    }
                }
            }
            Button(action: {
                isLoading.toggle()
                state.getSpirograph(planet1: planet1.rawValue, planet2: planet2.rawValue)
            }, label: {
                Text("Generate Spirograph".uppercased())
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
            
            ZStack {
                Text("Loading")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .offset(x: 0, y: -25)
     
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color(.systemGray5), lineWidth: 3)
                    .frame(width: 250, height: 3)
     
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 30, height: 3)
                    .offset(x: state.isLoading ? 110 : -110, y: 0)
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
            }
            .opacity(state.isLoading == true ? 1.0 : 0.0)
            
            let decodedImage = Data(base64Encoded: state.encodedImage) ?? Data()
            let image = (UIImage(data: decodedImage) ?? UIImage(systemName: "questionmark.folder.fill"))
        
            Image(uiImage: image!)
                .resizable()
                .frame(width: 400.0, height: 400.0)
                .scaledToFit()
            
            
        }
        .pickerStyle(.menu)
    }
}

struct SpirographView_Previews: PreviewProvider {
    static var previews: some View {
        SpirographView()
    }
}
