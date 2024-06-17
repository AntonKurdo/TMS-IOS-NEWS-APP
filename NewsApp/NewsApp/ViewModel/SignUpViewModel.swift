import Foundation
import Combine

final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    @Published var isButtonDisabled = true
    
    private var publishers = Set<AnyCancellable>()
    
    private let authService = AuthService.shared
    
    init() {
        isLoginFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isButtonDisabled, on: self)
            .store(in: &publishers)
    }
    
    func signUp() {
        authService.signUp(email: email, password: password)
    }
    
    func googleSignIn() async {
        try? await authService.googleSignIn()
    }
}


private extension SignUpViewModel {
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
        Publishers.CombineLatest3(
            isEmailValidPublisher,
            isPasswordValidPublisher,
            passwordMatchesPublisher)
        .map { isEmailValid, isPasswordValid, passwordMatches in
            return  !(isEmailValid && isPasswordValid && passwordMatches)
        }
        .eraseToAnyPublisher()
    }
    
    var passwordMatchesPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $repeatPassword)
            .map { password, repeated in
                return password == repeated
            }
            .eraseToAnyPublisher()
    }
}
