import UIKit
import SwiftUI

class AppCoordinator {
  private let window: UIWindow
  private var rootController: UIViewController?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let view = UIHostingController(rootView: LocationsView())
    
    window.rootViewController = view
  }
}

extension AppCoordinator: LocationsViewModelDelegate {
  func navigateForCoordinates(latitude: Double, longitude: Double) {
    // Todo: navigation
  }
}
