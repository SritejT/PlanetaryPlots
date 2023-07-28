//
//  PlotOrbitsHandler.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 13/07/2023.
//

import Foundation

struct GIFResponse: Codable {
    var encodedImage: String
}

class PlotOrbitsHandler {
    func requestOrbits(completionHandler: @escaping (String?) -> Void, options: [Bool]) {
        let url = URL(string: "https://6pdmq4zddzuv7ap7l4apdlcnam0avnmv.lambda-url.eu-north-1.on.aws/?Mercury=\(String(options[0]))&Venus=\(String(options[1]))&Earth=\(String(options[2]))&Mars=\(String(options[3]))&Jupiter=\(String(options[4]))&Saturn=\(String(options[5]))&Uranus=\(String(options[6]))&Neptune=\(String(options[7]))&Pluto=\(String(options[8]))")!
        
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
