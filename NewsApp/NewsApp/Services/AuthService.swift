import FirebaseAuth

final class AuthService: ObservableObject {
    
    static var shared: AuthService = AuthService()
    
    private let firebaseAuth = Auth.auth()
    
    @UserDefaultsWrapper<Bool>(key: "isAuth", default: false) private var userDefaultsIsAuth {
        didSet {
            DispatchQueue.main.async {
                self.isAuth = self.userDefaultsIsAuth
            }
        }
    }
    
    @Published var isAuth: Bool = false
    
    private init() {
        isAuth = userDefaultsIsAuth
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
                self.userDefaultsIsAuth = true
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
                self.userDefaultsIsAuth = true
                DispatchQueue.main.async {
                    successCompletion?()
                }
            }
        }
    }
    
    func logout() {
        DispatchQueue.global().async {
            do {
                try  self.firebaseAuth.signOut()
                self.userDefaultsIsAuth = false
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
    }
}
