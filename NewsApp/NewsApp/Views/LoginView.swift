import SwiftUI

struct LoginView: View {
    @ObservedObject var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 32)
            Image("icon").resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Spacer().frame(height: 24)
            Text("Continue with").fontWeight(.bold).font(.title3)
            Spacer().frame(height: 12)
            Text(LocalizedStringKey("Google button"))
            Spacer().frame(height: 12)
            Text(LocalizedStringKey("or")).fontWeight(.bold).font(.title3)
            Spacer().frame(height: 12)
            Text("Login To Your Account").fontWeight(.bold).font(.title3)
            Spacer().frame(height: 12)
            TextInput(label: "Email", placeholder: "Enter e-mail...", isRequired: true, value: $vm.email)
            Spacer().frame(height: 12)
            SecuredTextInput(label: "Password",placeholder: "Enter password...", isRequired: true, value: $vm.password)
            Spacer().frame(height: 164)
        }.scrollBounceBehavior(.basedOnSize)
            .safeAreaInset(edge: .bottom, content: {
                VStack {
                    TextButton(buttonLabel: "Login", isDisabled: $vm.isButtonDisabled) {
                        vm.signIn()
                    }
                    .padding(.top, 33)
                    .padding(.bottom, 12)
                    Spacer().frame(height: 8)
                    HStack {
                        Text("Dont have an account?").font(.subheadline)
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up").foregroundStyle(.accent).fontWeight(.bold).font(.subheadline)
                        }
                    }
                }
            })
    }
}
