import Foundation
import Networking

protocol LocationsRespositoryProtocol: AnyObject {
  func fetch() async throws -> Locations
}

public final class LocationsRepository: LocationsRespositoryProtocol {
  
  private let apiClient: ApiClient
  
  init(apiClient: ApiClient = .init()) {
    self.apiClient = apiClient
  }
  
  func fetch() async throws -> Locations {
    try await apiClient.request()
  }
}
