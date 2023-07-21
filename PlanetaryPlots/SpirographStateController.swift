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
    
    func getSpirograph(planet1: String, planet2: String) {
        self.isLoading = true
        spirographHandler.requestSpirograph(completionHandler: updateImageData, planet1: planet1, planet2: planet2)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.encodedImage = image ?? "Error finding image."
            self.isLoading = false
        }
    }
}
