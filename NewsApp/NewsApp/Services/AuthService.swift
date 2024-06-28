import FirebaseCore
import SwiftUI
import FirebaseAuth
import GoogleSignIn

final class AuthService: ObservableObject {
    
    static var shared: AuthService = AuthService()
    
    let firebaseAuth = Auth.auth()
    
    @Published var isAuth: Bool = (Auth.auth().currentUser != nil)
    
    private init() {
        Auth.auth().addStateDidChangeListener{ auth, user in
            if (user != nil) {
                self.isAuth = true
            } else {
                self.isAuth = false
            }
        }
    }
    
    func signUp(email: String, password: String, successCompletion: ( () -> ())? = nil, errorCompletion: ((_ error: Error) -> ())? = nil) {
        DispatchQueue.global().async {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error ?? "")
                    if let error = error {
                        DispatchQueue.main.async {
                            errorCompletion?(error)
                        }
                    }
                    return
                }
                DispatchQueue.main.async {
                    successCompletion?()
                }
            }
        }
    }
    
    func signIn(email: String, password: String, successCompletion: ( () -> ())? = nil, errorCompletion: ((_ error: Error) -> ())? = nil) {
        DispatchQueue.global().async {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    if let error = error {
                        DispatchQueue.main.async {
                            errorCompletion?(error)
                        }
                    }
                    return
                }
                DispatchQueue.main.async {
                    successCompletion?()
                }
            }
        }
    }
    
    func logout() {
        DispatchQueue.global().async {
            do {
                GIDSignIn.sharedInstance.signOut()
                try  self.firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
    }
    
    func googleSignIn() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let scene = await UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let rootViewController = await scene?.windows.first?.rootViewController else {
            return
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController
        )
        
        let user = result.user
        
        guard let idToken = user.idToken?.tokenString else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken, accessToken: user.accessToken.tokenString
        )
        
        try await Auth.auth().signIn(with: credential)
    }
}
