//
//  RelativeOrbitsHandler.swift
//  PlanetaryPlots
//
//  Created by Sritej Tummuru on 22/07/2023.
//

import Foundation

class RelativeOrbitsHandler {
    func requestRelativeOrbit(completionHandler: @escaping (String?) -> Void, orbitalPeriod1: String, semiMajorAxis1: String, eccentricity1: String, orbitalPeriod2: String, semiMajorAxis2: String, eccentricity2: String) {
        let url = URL(string: "https://iekrs4co7o2qgrczxtkeokzar40zkshf.lambda-url.eu-north-1.on.aws/?orbitalPeriod1=\(orbitalPeriod1)&semiMajorAxis1=\(semiMajorAxis1)&eccentricity1=\(eccentricity1)&orbitalPeriod2=\(orbitalPeriod2)&semiMajorAxis2=\(semiMajorAxis2)&eccentricity2=\(eccentricity2)")!
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    completionHandler(response.encodedImage)
                } else {
                    completionHandler(nil)
                }
            }
        }.resume()
    }
        
    
    func parseJson(json: Data) -> ImageResponse? {
        let decoder = JSONDecoder()
        
        if let imageResponse = try? decoder.decode(ImageResponse.self, from: json) {
            return imageResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
    }
}
