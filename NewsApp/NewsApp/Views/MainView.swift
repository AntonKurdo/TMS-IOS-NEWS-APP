import SwiftUI

struct MainView: View {
    
    let authService = AuthService.shared
    var body: some View {
        Button {
            authService.logout()
        } label: {
            Text("Logout")
        }
    }
}
