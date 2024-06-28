import Foundation
import _PhotosUI_SwiftUI

final class ProfileViewModal: ObservableObject {
    
    private enum ProperiesNames {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let avatarUrl = "avatarUrl"
    }
    let languages = ["English", "Russian"]
    
    @UserDefaultsWrapper<String>(key: "app_language", default: "en") var appLanguage
    @Published var selectedLanguage = "English" {
        didSet {
            switch selectedLanguage {
            case "English":
                appLanguage = "en"
            case "Russian":
                appLanguage = "ru"
            default:
                appLanguage = "en"
            }
        }
    }
    
    private var didMount = false
    
    private let firestoreService = FirestoreService.shared
    private let authService = AuthService.shared
    
    @Published var loading = true
    @Published var avatarUrl = "" {
        didSet {
            guard let userId = authService.firebaseAuth.currentUser?.uid else { return }
            firestoreService.addOrUpdateDocument(userId: userId, fieldName: ProperiesNames.avatarUrl, property: avatarUrl)
        }
    }
    @Published var uiImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil
    @Published var firstName: String = "" {
        didSet {
            guard let userId = authService.firebaseAuth.currentUser?.uid else { return }
            firestoreService.addOrUpdateDocument(userId: userId, fieldName: ProperiesNames.firstName, property: firstName)
        }
    }
    @Published var lastName: String = "" {
        didSet {
            guard let userId = authService.firebaseAuth.currentUser?.uid else { return }
            firestoreService.addOrUpdateDocument(userId: userId, fieldName: ProperiesNames.lastName, property: lastName )
        }
    }
    
    func logout() {
        authService.logout()
    }
    private func checkLanguage() {
        switch appLanguage {
        case "en":
            selectedLanguage = "English"
        case "ru":
            selectedLanguage = "Russian"
        default:
            selectedLanguage = "English"
        }
    }
    
    func getDataFromStorage() {
        if didMount {
            return
        }
        didMount = true
        checkLanguage()
        guard let userId = authService.firebaseAuth.currentUser?.uid else { return }
        
        firestoreService.getDocument(userId: userId, propertyName: ProperiesNames.firstName,  completion: { value in
            guard let value else {return}
            self.firstName = value
        })
        
        firestoreService.getDocument(userId: userId, propertyName: ProperiesNames.lastName,  completion: { value in
            guard let value else {return}
            self.lastName = value
        })
        
        self.firestoreService.getDocument(userId: userId, propertyName: ProperiesNames.avatarUrl,  completion: { value in
            guard let value else {
                self.loading = false
                return
            }

            let imageData = try? Data(contentsOf: URL(string: value) ?? .applicationDirectory)
            
            if let data = imageData {
                DispatchQueue.main.async {
                    self.uiImage = UIImage(data: data)
                    self.loading = false
                }
            } else {
                self.loading = false
            }
        })
    }
}
