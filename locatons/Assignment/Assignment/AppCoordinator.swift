import UIKit

class AppCoordinator {
  private let window: UIWindow
  private var rootController: UIViewController?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    rootController = UINavigationController(rootViewController: ViewController())
    window.rootViewController = rootController
  }
}

let locations: [LocationsViewDataItem] = [
  .init(
    name: "Amsterdam",
    coordinates: .init(latitude: 52.3547498, longitude: 52.3547498)
  ),
  .init(
    name: "Mumbai",
    coordinates: .init(latitude: 19.0823998, longitude: 72.8111468)
  )
]
