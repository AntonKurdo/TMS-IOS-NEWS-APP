import SwiftUI

struct Tabs: View {
    @State private var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    MainView()
                        .navigationTitle("Home")
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(Tab.home)
                
                Text("Favourites")
                    .tabItem {
                        Label("Favourites", systemImage: "heart.fill")
                    }.tag(Tab.favourites)
                
                Text("Profile")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }.tag(Tab.profile)
            }
            CustomBottomTabBarView(currentTab: $selectedTab)
        }
    }
}






