import Foundation

public enum APIConfig {
  public static var apiBaseUrl: URL {
    guard let url = URL(
      string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/refs/heads/main/locations.json"
    ) else {
      preconditionFailure("API url did not intialize.")
    }

    return url
  }
}
