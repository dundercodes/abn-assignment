import Foundation

enum ViewState {
  case loading
  case dataLoaded([Location])
  case error
}
