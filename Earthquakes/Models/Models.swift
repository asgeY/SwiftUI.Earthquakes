import Foundation
import SwiftUI

struct EarthQuakeResponse : Codable {
    var features: [Feature]
}


struct ResponseMetaData : Codable {
    var url: String
    var status: Int
    var count: Int
    var title: String
}


struct Feature : Codable {
    var properties: Properties
    var geometry: Geometry
}


struct Properties : Codable {
    var mag: Double
    var place: String
    var time: Double
    var detail: String
    var title: String
}


struct Geometry : Codable, Hashable {
    var type: String
    var coordinates: [Double]
}
