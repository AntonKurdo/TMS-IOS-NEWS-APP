import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var scrolledID: Int? = 0
    
    @UserDefaultsWrapper<Bool>(key: "isOnboardingFinished", default: false) var isOnboardingFinished
}
