import Foundation

struct WikipediaUrlBuilder {
  static let wikipediaUrlScheme = "wikipedia"

  static func build(latitude: Double, longitude: Double) -> URL? {
    var components = URLComponents()
    components.scheme = wikipediaUrlScheme
    components.host = "places"
    components.path = "/coordinates"
    components.queryItems = [
      .init(name: "lat", value: latitude.description),
      .init(name: "long", value: longitude.description)
    ]
    
    return components.url
  }
}
