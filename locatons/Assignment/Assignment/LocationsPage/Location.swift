import Foundation

struct Location: Codable {
  let name: String?
  let lat: Double
  let long: Double
}

extension Location: CustomStringConvertible {
  var description: String {
    let lat = lat.formatted(.number.precision(.fractionLength(4)))
    let long = long.formatted(.number.precision(.fractionLength(4)))
    
    return "\(lat), \(long)"
  }
}
