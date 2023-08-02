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
    @Published var buttonDisabled = false
    let relativeOrbitsHandler = RelativeOrbitsHandler()
    
    func getRelativeOrbit(orbitalPeriod1: String, semiMajorAxis1: String, eccentricity1: String, orbitalPeriod2: String, semiMajorAxis2: String, eccentricity2: String) {
        self.isLoading = true
        self.buttonDisabled = true
        relativeOrbitsHandler.requestRelativeOrbit(completionHandler: updateImageData, orbitalPeriod1: orbitalPeriod1, semiMajorAxis1: semiMajorAxis1, eccentricity1: eccentricity1, orbitalPeriod2: orbitalPeriod2, semiMajorAxis2: semiMajorAxis2, eccentricity2: eccentricity2)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.encodedImage = image ?? "Error finding image."
            self.isLoading = false
            self.buttonDisabled = false
        }
    }
}
