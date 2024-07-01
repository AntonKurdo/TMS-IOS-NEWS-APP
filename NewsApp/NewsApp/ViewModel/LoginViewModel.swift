import Foundation
import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @Published var isButtonDisabled = true
    
    private var publishers = Set<AnyCancellable>()
    
    private let authService = AuthService.shared
    
    init() {
        isLoginFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isButtonDisabled, on: self)
            .store(in: &publishers)
    }
    
    func signIn(alerter: Alerter) {
        authService.signIn(email: email, password: password, errorCompletion: { error in
            alerter.alert = Alert(title: Text("Error"), message: Text(error.localizedDescription))
        })
    }
    
    func googleSignIn() async {
        try? await authService.googleSignIn()
    }
}

private extension LoginViewModel {
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                return email.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                return password.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    var isLoginFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isEmailValidPublisher,
            isPasswordValidPublisher)
        .map { isEmailValid, isPasswordValid in
            return  !(isEmailValid && isPasswordValid )
        }
        .eraseToAnyPublisher()
    }
}
