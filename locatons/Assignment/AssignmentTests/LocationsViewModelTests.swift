@testable import Assignment
import XCTest

final class LocationsViewModelTests: XCTestCase {
  
  private var sut: LocationsViewModel!
  private var locationsRepository: LocationsRepositoryMock!
  private var delegate: LocationsViewModelDelegateMock!
  
  override func setUp() {
    super.setUp()
    locationsRepository = .init()
    delegate = .init()
    sut = .init(locationsRepository: locationsRepository)
    sut.delegate = delegate
  }
  
  func testViewDidAppear_whenRepositoryThrowsError_shouldUpdateViewStateToError() {
    // Arrange
    locationsRepository.locations = .failure(NSError())
    let errorExpectation = XCTestExpectation()
    
    // Act
    sut.viewDidAppear {
      errorExpectation.fulfill()
    }
    wait(for: [errorExpectation], timeout: 1)
    
    // Assert
    guard case .error = sut.state else {
      XCTFail()
      return
    }
  }

  func testViewDidAppear_whenRepositoryReturnsLocations_shouldUpdateViewStateToLoadedData() {
    // Arrange
    let dataLoadedExpectation = XCTestExpectation()
    
    // Act
    sut.viewDidAppear {
      dataLoadedExpectation.fulfill()
    }
    wait(for: [dataLoadedExpectation], timeout: 1)
    
    // Assert
    guard case .dataLoaded(let locations) = sut.state else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(locations.count, 1)
    XCTAssertEqual(locations.first?.name, "Amsterdam")
    XCTAssertEqual(locations.first?.lat, 52.3547498)
    XCTAssertEqual(locations.first?.long, 4.8339215)
  }
  
  func testDidSelectExistingLocation_givenNonNilCoordinates_shouldNotCallDelegate() {
    // Arrange
    let lat: Double? = Location.mock.lat
    let long: Double? = Location.mock.long
    
    // Act
    sut.didInputNewLocation(latitude: lat, longitude: long)
    
    // Assert
    XCTAssertTrue(delegate.isCalled)
  }

  func testDidInputNewLocation_givenNilCoordinates_shouldNotCallDelegate() {
    // Arrange
    let lat: Double? = nil
    let long: Double? = nil
    
    // Act
    sut.didInputNewLocation(latitude: lat, longitude: long)
    
    // Assert
    XCTAssertFalse(delegate.isCalled)
  }
  
  func testDidInputNewLocation_givenNonNilCoordinates_shouldNotCallDelegate() {
    // Arrange
    let location = Location.mock
    
    // Act
    sut.didSelectExistingLocation(location)
    
    // Assert
    XCTAssertTrue(delegate.isCalled)
  }

}

