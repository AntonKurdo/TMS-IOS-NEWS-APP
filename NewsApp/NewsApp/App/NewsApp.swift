import SwiftUI
import GoogleSignIn

@Observable
class AppSettings {
    var locale = Locale(identifier: "en")
}

@main
struct NewsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var alerter: Alerter = Alerter()
    @State var appSettings = AppSettings()
    
    @ObservedObject var sharedFavouritesViewModal: FavouritesViewModel = FavouritesViewModel()
    
    @UserDefaultsWrapper<String>(key: "app_language", default: "en") var appLanguage
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(appSettings)
                .environment(\.locale, appSettings.locale)
                .environmentObject(alerter)
                .environmentObject(sharedFavouritesViewModal)
                .alert(isPresented: $alerter.isShowingAlert) {
                    alerter.alert ?? Alert(title: Text(""))
                }
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }.onAppear {
                    sharedFavouritesViewModal.pullNewsFromStore()
                    switch appLanguage {
                    case "en":
                        appSettings.locale = Locale(identifier: "en")
                    case "ru":
                        appSettings.locale = Locale(identifier: "ru")
                    default:
                        appSettings.locale = Locale(identifier: "en")
                    }
                }
        }
    }
}



