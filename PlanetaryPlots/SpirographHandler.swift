//
//  SpirographHandler.swift
//  PlanetaryPlots
//
//  Created by Ravindra Tummuru on 20/07/2023.
//

import Foundation

struct ImageResponse: Codable {
    var encodedImage: String
}

class SpirographHandler {
    
    func requestSpirograph(completionHandler: @escaping (String?) -> Void, planet1: String, planet2: String) {
        let url = URL(string: "https://6d53tbbu5bn3ce3efdvzzzmuh40yjpce.lambda-url.eu-north-1.on.aws/?Planet1=\(planet1)&Planet2=\(planet2)")!
        
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
