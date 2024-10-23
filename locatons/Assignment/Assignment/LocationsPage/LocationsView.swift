import SwiftUI

struct LocationsView: View {
  
  @State private var customLatitude: Double? = nil
  @State private var customLongitude: Double? = nil
  
  @ObservedObject var viewModel: LocationsViewModel
  
  init(viewModel: LocationsViewModel = .init(), delegate: LocationsViewModelDelegate?) {
    self.viewModel = viewModel
    self.viewModel.delegate = delegate
  }
  
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
    Section("Known locations") {
      ForEach(locations.indices, id: \.self) { index in
        let location = locations[index]
        VStack(alignment: .leading) {
          if let name = location.name, !name.isEmpty {
            Text(name)
          }
          
          Text(location.description)
            .font(.caption)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(location.name ?? location.description)
        .accessibilityAddTraits(.isButton)
        .accessibilityRemoveTraits(.isHeader)
        .onTapGesture {
          viewModel.didSelectExistingLocation(location)
        }
      }
    }
  }
  
  func newLocationInputs(_ onTapGo: @escaping (Double?, Double?) -> Void) -> some View {
    Section("New coordinates") {
      let latitudeKey: LocalizedStringKey = "Latitude"
      TextField(latitudeKey, value: $customLatitude, format: .number)
        .accessibilityLabel(latitudeKey)
        .accessibilityValue(customLatitude?.description ?? "")

      let longitudeKey: LocalizedStringKey = "Longitude"
      TextField(longitudeKey, value: $customLongitude, format: .number)
        .accessibilityLabel(longitudeKey)
        .accessibilityValue(customLongitude?.description ?? "")

      Button("Go") {
        onTapGo(customLatitude, customLongitude)
      }
    }
    .keyboardType(.decimalPad)
  }
}
