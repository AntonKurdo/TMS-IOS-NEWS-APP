import SwiftUI

struct TextInput: View {
    
    var label: String
    var placeholder: String
    var isRequired = false
    
    @Binding var value: String
    
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
            
            TextField(
                LocalizedStringKey(placeholder),
                text: $value
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
        }.padding(.horizontal)
    }
}
