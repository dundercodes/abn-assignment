# ABN Amro iOS Assignment

The assignment contains 2 folders:
- `wikipedia-ios`: contains the Wikipedia iOS app respository with changes to catch coordinates passed in a deeplink and open them in the Places tab.
- `locations`: simple app that fetches locations from a server and allows user to open these locations in the Wikipedia app. 

<center>
<img src="./demo.gif" height="600" />
</center>

## Tech stack
- Xcode 15.4
- Swift 5
- iOS 17+
- Swift packages 

I have used no external dependencies for the Locations app. Locations app contains one local Swift package `Networking` containing classes and configurations responsible for sending requests to backend API. This will keep the app's code modularized, providing benefits such as faster incremental build times, ability to share code between  modules and fewer git conflicts for team members working on different parts of the app.  

## Wikipedia deeplink
I have expanded the existing deeplink URL pattern used by the wikipedia app for places, by adding a coordinates path with query parameter: `wikipedia://places/coordinates?lat={latitude}&long={longitude}`.

## Architecture
For the locatons app, I have chosen an MVVM based approach alongside Coordinator pattern. MVVM is a very common UI pattern and works fluently with SwiftUI out of the box, thereby making it an ideal. At the same time, I prefer to keep navigation logic separate from views, which is why I have introduced `AppCoordinator` class in order to handle the navigation between screens and external apps i.e. Wikipedia.

## Tests
I have also written unit tests for various classes in Locations app and for each test case, I have used AAA (Arrange, Act, Assert) pattern where possible, because it's well known and keeps a predictable structure to each test case. 

I have also added unit tests for the changes made inside the Wikipedia, to verify that coordinates are being extracted correctly from the deeplink URL.