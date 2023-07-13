//
//  PlotOrbitsHandler.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import Foundation

struct ImageResponse: Codable {
    var encodedImage: String
}

class PlotOrbitsHandler {
    func requestOrbits(completionHandler: @escaping (String?) -> Void) {
        let url = URL(string: "https://6pdmq4zddzuv7ap7l4apdlcnam0avnmv.lambda-url.eu-north-1.on.aws/")!
        
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
