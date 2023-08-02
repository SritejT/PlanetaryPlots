//
//  StateController.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import Foundation

class PlotOrbitsStateController: ObservableObject {
    @Published var encodedImage: String = ""
    @Published var isLoading = false
    @Published var buttonDisabled = false
    let plotOrbitsHandler = PlotOrbitsHandler()
    
    func getInnerSolarSystemOrbits(options: [Bool]) {
        self.isLoading = true
        self.buttonDisabled = true
        plotOrbitsHandler.requestOrbits(completionHandler: updateImageData, options: options)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.buttonDisabled = false
            self.encodedImage = image!
        }
    }
}
