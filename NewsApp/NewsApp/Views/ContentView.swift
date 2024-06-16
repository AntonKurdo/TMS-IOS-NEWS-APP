import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authService: AuthService = AuthService.shared
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            NavigationView {
                if authService.isAuth {
                    Button {
                        authService.logout()
                    } label: {
                        Text("Logout")
                    }
                } else {
                    LoginView()
                }
            }
        }
    }
}
