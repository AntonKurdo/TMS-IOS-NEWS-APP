import SwiftUI
import GoogleSignIn

@main
struct NewsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var alerter: Alerter = Alerter()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(alerter)
                .alert(isPresented: $alerter.isShowingAlert) {
                    alerter.alert ?? Alert(title: Text(""))
                }
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
