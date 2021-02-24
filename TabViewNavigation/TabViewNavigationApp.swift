import SwiftUI

@main
struct TabViewNavigationApp: App {

  @Environment(\.scenePhase) var scenePhase

  var appState = AppState()

  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(appState)
    }
    .onChange(of: scenePhase) {
      switch $0 {
      case .active:
        // Un-comment out to set inital state.
//        appState.selectedSite = "site"
//        appState.selectedZone = "zone"
        break
      case .background:
        break
      case .inactive:
        break
      @unknown default:
        break
      }
    }
  }
}
