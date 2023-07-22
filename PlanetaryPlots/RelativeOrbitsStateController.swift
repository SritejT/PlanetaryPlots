//
//  RelativeOrbitsStateController.swift
//  PlanetaryPlots
//
//  Created by Sritej Tummuru on 22/07/2023.
//

import Foundation

class RelativeOrbitsStateController: ObservableObject {
    @Published var encodedImage: String = ""
    @Published var isLoading = false
    let relativeOrbitsHandler = RelativeOrbitsHandler()
    
    func getRelativeOrbit(planet1: String, planet2: String) {
        self.isLoading = true
        relativeOrbitsHandler.requestRelativeOrbit(completionHandler: updateImageData, planet1: planet1, planet2: planet2)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.encodedImage = image ?? "Error finding image."
            self.isLoading = false
        }
    }
}
