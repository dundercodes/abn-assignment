import Foundation
import Combine
import Networking

final class LocationsViewModel: ObservableObject {
  
  @Published var state: ViewState = .loading
  
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
  
  func didSelectExistingLocation(at index: Int) {
    // Todo: Navigation
  }
}
