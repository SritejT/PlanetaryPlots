//
//  CheckboxToggle.swift
//  PlanetaryPlots
//
//  Created by Sritej Tummuru on 28/07/2023.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
 
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
        .background(Color(red: 0, green: 0.50, blue: 1)
                        .opacity(0.75))
        .cornerRadius(10)
        
 
    }
}

struct CheckboxToggle: View {
    var isOn: Binding<Bool>
    let label: String
    
    init(label: String, isOn: Binding<Bool>) {
        self.isOn = isOn
        self.label = label
    }
    
    var body: some View {
        Toggle(isOn: self.isOn, label: {
            Text(self.label)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: 80, alignment: .trailing)
        })
        .toggleStyle(CheckboxStyle())
    }
}

struct CheckboxToggle_Previews: PreviewProvider {
    @State private var toggleState: Bool = false
    static var previews: some View {
        Text("text")
    }
}
