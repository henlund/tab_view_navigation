import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState

  var body: some View {
    if let _ = appState.selectedSite {
      MainView()
    } else {
      DiscoveryView()
    }
  }
}

struct MainView: View {
  @EnvironmentObject var appState: AppState

  var body: some View {
    TabView(selection: $appState.selectedTab) {
      NavigationView {
        FirstView()
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .tabItem {
        Image(systemName: "1.circle")
        Text("First")
      }
      .tag(Tab.firstTab)

      NavigationView {
        FourthView()
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .tabItem {
        Image(systemName: "2.circle")
        Text("Second")
      }
      .tag(Tab.secondTab)
    }
  }
}

struct DiscoveryView: View {

  @EnvironmentObject var appState: AppState

  var body: some View {
    NavigationView {
      VStack {
        Text("Discovery View")
        Button("Select device") {
          appState.selectedSite = "site"
        }.navigationBarTitle("Discovery View", displayMode: .inline)
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct FirstView: View {

  @EnvironmentObject var appState: AppState

  var body: some View {
    VStack {
      if let _ = appState.selectedZone {
        NavigationLink(destination: SecondView(), isActive: .constant(true)) {
          EmptyView()
        }
      }
      NavigationLink(destination: SecondView(), tag: .showSecondView, selection: $appState.firstViewNavigationState) {
        EmptyView()
      }
      NavigationLink(destination: ThirdView(), tag: .showThirdView, selection: $appState.firstViewNavigationState) {
        EmptyView()
      }
      Text("First View")
      Button("Show second view") {
        appState.firstViewNavigationState = .showSecondView
      }
      Button("Show second tab") {
        appState.selectedTab = .secondTab
      }
      .navigationBarTitle("First View", displayMode: .inline)
    }
  }
}

extension FirstView {
  enum NavigationState {
    case showSecondView
    case showThirdView
  }
}

struct SecondView: View {

  @EnvironmentObject var appState: AppState

  var body: some View {
    VStack {
      NavigationLink(destination: ThirdView(), tag: .showThirdView, selection: $appState.secondViewNavigationState) {
        EmptyView()
      }
      Text("Second View")
      Button("Show third view") {
        appState.secondViewNavigationState = .showThirdView
      }
    }
    .navigationBarTitle("Second View", displayMode: .inline)
  }
}

extension SecondView {
  enum NavigationState {
    case showThirdView
  }
}

struct ThirdView: View {
  var body: some View {
    Text("Third View")
      .navigationBarTitle("Third View", displayMode: .inline)
  }
}

struct FourthView: View {

  @EnvironmentObject var appState: AppState

  var body: some View {
    VStack {
      Text("Fourth View")
      Button("Disconnect") {
        appState.selectedTab = .firstTab
        appState.selectedSite = nil
      }
    }
    .navigationBarTitle("Fourth View", displayMode: .inline)
  }
}

class AppState: ObservableObject {
  @Published var selectedSite: String? = nil
  @Published var selectedZone: String? = nil
  @Published var selectedA: String? = nil
  @Published var selectedTab: Tab = .firstTab
  @Published var firstViewNavigationState: FirstView.NavigationState?
  @Published var secondViewNavigationState: SecondView.NavigationState?
}

enum Tab: Hashable {
  case firstTab
  case secondTab
}

enum AppSection: Hashable {
  case firstView
  case secondView
  case thirdView
}
