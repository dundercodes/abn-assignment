import Foundation
import Combine
import Networking

protocol LocationsViewModelDelegate: AnyObject {
  func navigateForCoordinates(latitude: Double, longitude: Double)
}

final class LocationsViewModel: ObservableObject {
  
  @Published var state: ViewState = .loading
  
  weak var delegate: LocationsViewModelDelegate?
  private let apiClient: ApiClient
  
  init(apiClient: ApiClient = .init()) {
    self.apiClient = apiClient
  }
  
  func viewDidAppear() {
    Task {
      do {
        let locations: Locations = try await apiClient.request()
        
        await MainActor.run {
          state = .dataLoaded(locations.locations)
        }
      } catch {
        await MainActor.run {
          state = .error
        }
      }
    }
  }
  
  func didSelectExistingLocation(_ location: Location) {
    delegate?.navigateForCoordinates(latitude: location.lat, longitude: location.long)
  }
  
  func didInputNewLocation(latitude: Double?, longitude: Double?) {
    guard let latitude, let longitude else { return }
    
    delegate?.navigateForCoordinates(latitude: latitude, longitude: longitude)
  }
}
