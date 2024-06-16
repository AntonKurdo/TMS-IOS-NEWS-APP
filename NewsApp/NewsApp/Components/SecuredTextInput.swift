import SwiftUI

struct SecuredTextInput: View {
    
    var label: String
    var placeholder: String
    
    var isRequired = false
    
    @Binding var value: String
    @State var isSecure: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                if isRequired {
                    Group {
                        Text(LocalizedStringKey(label)).font(.title3) +
                        Text("*").foregroundColor(.red)
                    }
                } else {
                    Text(LocalizedStringKey(label)).font(.title3)
                }
                Spacer()
            }
            
            ZStack(alignment: .trailing){
                if isSecure {
                    SecureField(
                        LocalizedStringKey(placeholder),
                        text: $value
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        isSecure = !isSecure
                    }, label: {
                        Image(systemName: isSecure ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    })
                } else {
                    TextField(
                        placeholder,
                        text: $value
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        isSecure = !isSecure
                    }, label: {
                        Image(systemName: isSecure ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    })
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isSecure)
        }.padding(.horizontal)
    }
}
