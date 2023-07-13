//
//  StateController.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import Foundation

class PlotOrbitsStateController: ObservableObject {
    @Published var encodedImage: String = ""
    let plotOrbitsHandler = PlotOrbitsHandler()
    
    func getInnerSolarSystemOrbits() {
        plotOrbitsHandler.requestOrbits(completionHandler: updateImageData)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.encodedImage = image ?? "Error finding image."
        }
    }
}
