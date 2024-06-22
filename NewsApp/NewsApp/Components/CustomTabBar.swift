import SwiftUI

private let buttonDimen: CGFloat = 70

struct CustomBottomTabBarView: View {
    
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack {
            TabBarButton(imageName: Tab.home.rawValue)
                .frame(width: buttonDimen, height: buttonDimen)
                .onTapGesture {
                    currentTab = .home
                }
            
            Spacer()

            TabBarButton(imageName: Tab.favourites.rawValue)
                .frame(width: buttonDimen, height: buttonDimen)
                .onTapGesture {
                    currentTab = .favourites
                }

            Spacer()
            
            TabBarButton(imageName: Tab.profile.rawValue)
                .frame(width: buttonDimen, height: buttonDimen)
                .onTapGesture {
                    currentTab = .profile
                }
        }
        .frame(width: (buttonDimen * CGFloat(Tab.allCases.count)) + 60)
        .tint(Color.black)
        .padding(.vertical, 2.5)
        .background(Color.white)
        .clipShape(Capsule(style: .continuous))
        .overlay {
            SelectedTabCircleView(currentTab: $currentTab)
        }
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 10)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.65), value: currentTab)
    }
    
}

private struct TabBarButton: View {
    let imageName: String
    var body: some View {
        Image(systemName: imageName)
            .renderingMode(.template)
            .tint(.black)
            .fontWeight(.bold)
    }
}

struct SelectedTabCircleView: View {
    
    @Binding var currentTab: Tab
    
    private var horizontalOffset: CGFloat {
        switch currentTab {
        case .home:
            return -100
    
        case .favourites:
            return 0
      
        case .profile:
            return 100
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: buttonDimen , height: buttonDimen)
            
            TabBarButton(imageName: "\(currentTab.rawValue).fill")
                .foregroundColor(.white)
        }
        .offset(x: horizontalOffset)
    }

}

