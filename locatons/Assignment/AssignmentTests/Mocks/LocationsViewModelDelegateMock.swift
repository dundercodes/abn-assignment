@testable import Assignment

final class LocationsViewModelDelegateMock: LocationsViewModelDelegate {
  var isCalled = false
  
  func navigateForCoordinates(latitude: Double, longitude: Double) {
    isCalled = true
  }
}
