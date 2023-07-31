//
//  SpirographStateController.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 20/07/2023.
//

import Foundation

class SpirographStateController: ObservableObject {
    @Published var encodedImage: String = ""
    @Published var isLoading = false
    let spirographHandler = SpirographHandler()
    
    func getSpirograph(orbitalPeriod1: String, semiMajorAxis1: String, eccentricity1: String, orbitalPeriod2: String, semiMajorAxis2: String, eccentricity2: String) {
        self.isLoading = true
        spirographHandler.requestSpirograph(completionHandler: updateImageData, orbitalPeriod1: orbitalPeriod1, semiMajorAxis1: semiMajorAxis1, eccentricity1: eccentricity1, orbitalPeriod2: orbitalPeriod2, semiMajorAxis2: semiMajorAxis2, eccentricity2: eccentricity2)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.encodedImage = image ?? "Error finding image."
            self.isLoading = false
        }
    }
}
