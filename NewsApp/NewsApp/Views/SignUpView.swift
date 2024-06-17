import SwiftUI
import GoogleSignInSwift

struct SignUpView: View {
    @ObservedObject var vm: SignUpViewModel = SignUpViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 32)
            Image("icon").resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Spacer().frame(height: 24)
            Text("Continue with").fontWeight(.bold).font(.title3)
            Spacer().frame(height: 12)
            GoogleSignInButton(style: .icon) {
                Task {
                    do {
                        await vm.googleSignIn()
                    }
                }
            }
            Spacer().frame(height: 12)
            Text("or").fontWeight(.bold).font(.title3)
            Spacer().frame(height: 12)
            Text("Sign Up With New Account").fontWeight(.bold).font(.title3)
            Spacer().frame(height: 12)
            TextInput(label: "Email", placeholder: "Enter e-mail:", isRequired: true, value: $vm.email)
            Spacer().frame(height: 12)
            SecuredTextInput(label: "Password",placeholder: "Enter password:", isRequired: true, value: $vm.password)
            Spacer().frame(height: 12)
            SecuredTextInput(label: "Repeat Password",placeholder: "Repeat password...", isRequired: true, value: $vm.repeatPassword)
            Spacer().frame(height: 164)
        }.scrollBounceBehavior(.basedOnSize)
            .safeAreaInset(edge: .bottom, content: {
                VStack {
                    TextButton(buttonLabel: "Sign Up", isDisabled: $vm.isButtonDisabled) {
                        self.vm.signUp()
                    }
                    .padding(.top, 33)
                    .padding(.bottom, 12)
                    Spacer().frame(height: 8)
                    HStack {
                        Text("Already have account?").font(.subheadline)
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Sign In").foregroundStyle(.accent).fontWeight(.bold).font(.subheadline)
                        }
                    }
                }
            })
    }
}
