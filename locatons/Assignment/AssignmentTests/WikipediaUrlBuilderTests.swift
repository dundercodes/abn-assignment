@testable import Assignment
import XCTest

final class WikipediaUrlBuilderTests: XCTestCase {
  private var sut: WikipediaUrlBuilder.Type!
  
  override func setUp() {
    super.setUp()
    
    sut = WikipediaUrlBuilder.self
  }
  
  func testBuild_givenCoordinates_shouldReturnNonNilUrl() {
    // Arrange
    let latitude = 52.3547498
    let longitude = 4.8339215
    
    // Act
    let result = sut.build(latitude: latitude, longitude: longitude)
    
    // Assert
    let expectedResult = "wikipedia://places/coordinates?lat=52.3547498&long=4.8339215"
    XCTAssertEqual(result?.absoluteString, expectedResult)
  }
}
