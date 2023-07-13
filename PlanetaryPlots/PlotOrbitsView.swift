//
//  PlotOrbitsView.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import SwiftUI


struct PlotOrbitsView: View {
    @StateObject private var state = PlotOrbitsStateController()
    
    var body: some View {
        Button("Plot Inner Solar System") {
            state.getInnerSolarSystemOrbits()
        }
        
        let decodedImage = Data(base64Encoded: state.encodedImage)!
        let image = (UIImage(data: decodedImage) ?? UIImage(systemName: "questionmark.folder.fill"))
        
        Image(uiImage: image!)
        
    }
}

struct PlotOrbitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlotOrbitsView()
    }
}
