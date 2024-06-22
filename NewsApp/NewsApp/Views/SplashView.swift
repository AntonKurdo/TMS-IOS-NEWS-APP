import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    @State private var opacity = 0.0
    
    let imageSize = UIScreen.main.bounds.width * 0.5
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                VStack {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                        .shadow(color: .gray, radius: 5)
                        .opacity(opacity)
                    Text("Newsify").font(.system(size: 40)).fontWeight(.light).foregroundColor(.accent).tracking(10).opacity(opacity)
                    
                }
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.7)) {
                self.opacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
            
        }
    }
        
}
