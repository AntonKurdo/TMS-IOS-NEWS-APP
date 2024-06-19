import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authService: AuthService = AuthService.shared
    
    @UserDefaultsWrapper<Bool>(key: "isOnboardingFinished", default: false) private var isOnboardingFinished
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            NavigationView {
                if authService.isAuth {
                    if isOnboardingFinished {
                        MainView()
                    } else {
                        OnboardingView()
                    }
                } else {
                    LoginView()
                }
            }
        }
    }
}
