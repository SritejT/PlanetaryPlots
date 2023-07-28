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
    let plotOrbitsHandler = PlotOrbitsHandler()
    
    func getInnerSolarSystemOrbits(options: [Bool]) {
        self.isLoading = true
        plotOrbitsHandler.requestOrbits(completionHandler: updateImageData, options: options)
    }
    
    
    func updateImageData(image: String?) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.encodedImage = image!
        }
    }
}
