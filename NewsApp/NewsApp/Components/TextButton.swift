import SwiftUI

struct TextButton: View {
    
    var buttonLabel: String
    
    @Binding var isDisabled: Bool
    
    var action: () -> ()
    
    var width: CGFloat = UIScreen.main.bounds.width * 0.65
    var height: CGFloat = 50
    
    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(buttonLabel))
                .font(.title3)
                .frame(width: width, height: height)
                .foregroundColor(.white)
                .background(isDisabled ? .gray  : .accent)
                .cornerRadius(100)
        }.disabled(isDisabled)
    }
}
