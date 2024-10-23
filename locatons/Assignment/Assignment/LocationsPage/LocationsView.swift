import SwiftUI

struct LocationsView: View {
  
  @State private var customLatitude: Double? = nil
  @State private var customLongitude: Double? = nil
  
  @ObservedObject var viewModel: LocationsViewModel = .init()
  
  var body: some View {
    Group {
      switch viewModel.state {
      case .loading:
        ProgressView()
      case .dataLoaded(let data):
        NavigationView {
          List {
            existingLocationsSection(data)
            
            newLocationInputs(viewModel.didInputNewLocation(latitude:longitude:))
          }
          .navigationTitle("Locations")
        }
      case .error:
        Label("Oops! Something went wrong! Please try again later.", systemImage: "exclamationmark.triangle")
      }
    }
    .onAppear {
      viewModel.viewDidAppear()
    }
  }
}

// MARK: - Private
private extension LocationsView {
  func existingLocationsSection(_ locations: [Location]) -> some View {
    Section("Existing") {
      ForEach(locations.indices, id: \.self) { index in
        let location = locations[index]
        VStack(alignment: .leading) {
          if let name = location.name, !name.isEmpty {
            Text(name)
          }
          
          Text(location.description)
            .font(.caption)
        }
        .onTapGesture {
          viewModel.didSelectExistingLocation(at: index)
        }
      }
    }
  }
  
  func newLocationInputs(_ onTapGo: @escaping (Double?, Double?) -> Void) -> some View {
    Section("New") {
      TextField("Latitude", value: $customLatitude, format: .number)
      TextField("Longitude", value: $customLongitude, format: .number)
      
      Button("Go") {
        onTapGo(customLatitude, customLongitude)
      }
    }
    .keyboardType(.decimalPad)
  }
}
