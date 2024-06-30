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
                        Tabs()
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




