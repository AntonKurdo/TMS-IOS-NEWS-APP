import SwiftUI

struct Tabs: View {
    @State private var selectedTab: Tab = .home
    
    private let authService = AuthService.shared
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationView {
                    HomeView()
                }.tag(Tab.home)
                Text("Favourites").tag(Tab.favourites)
                ProfileView()
                    .tag(Tab.profile)
                
            }
            CustomBottomTabBarView(currentTab: $selectedTab)
        }
    }
}






