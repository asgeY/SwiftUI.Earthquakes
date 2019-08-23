import Foundation
import SwiftUI
import Combine

class NetworkingManager : BindableObject {
    
    var didChange = PassthroughSubject<NetworkingManager, Never>()
    
    var earthquakes = EarthQuakeResponse(features: []) {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        guard let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_hour.geojson") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            do {
                let earthquakes = try JSONDecoder().decode(EarthQuakeResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.earthquakes = earthquakes
                    print(self.earthquakes)
                }
                
            }
            catch let err {
                print(err.localizedDescription)
            }
        }.resume()
    }
    
}
