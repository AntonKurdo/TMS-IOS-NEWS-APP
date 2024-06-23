import SwiftUI

struct Tabs: View {
    @State private var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView().tag(Tab.home)
                Text("Favourites").tag(Tab.favourites)
                Text("Profile").tag(Tab.profile)
            }
            CustomBottomTabBarView(currentTab: $selectedTab)
        }
    }
}






