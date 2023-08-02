//
//  LoadingView.swift
//  PlanetaryPlots
//
//  Created by Sritej Tummuru on 01/08/2023.
//

import SwiftUI

struct LoadingView: View {
    
    @State var progress = 0.0
    @State var running = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(red: 0.9, green: 0.95, blue: 1),
                    lineWidth: 5
                )
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(running ? 270 : -90))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: running)
            
                .onAppear {
                    running = true
                }
        }
        .frame(maxWidth: 40)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
