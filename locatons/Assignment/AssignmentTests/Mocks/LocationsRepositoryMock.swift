@testable import Assignment
import Foundation

final class LocationsRepositoryMock: LocationsRespositoryProtocol {
  var locations: Result<Locations, Error> = .success(Locations(
    locations: [.mock]
  ))

  func fetch() async throws -> Locations {
    switch locations {
    case .success(let data):
      return data
    case .failure(let error):
      throw error
    }
  }
}
