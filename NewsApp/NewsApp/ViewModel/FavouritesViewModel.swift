import Foundation
import Firebase
import FirebaseAuth

final class FavouritesViewModel: ObservableObject {
    
    private var didMount = false
    
    private enum ProperiesNames {
        static let favourites = "favourites"
    }
    
    @Published var news: [Article] = [] {
        didSet {
            pushNewsToStore()
        }
    }

    lazy private var firestoreService = FirestoreService.shared
    lazy private var authService = AuthService.shared
    
    private func pushNewsToStore() {
        guard let userId = authService.firebaseAuth.currentUser?.uid else { return }
        firestoreService.addOrUpdateDocument(userId: userId, fieldName: ProperiesNames.favourites, property: news.map({ art in
            return [
                "source": ["id": art.source.id, "name": art.source.name],
                "title": art.title,
                "description": art.description ?? "",
                "author": art.author ?? "",
                "url": art.url,
                "urlToImage": art.urlToImage ?? "",
                "publishedAt": art.publishedAt,
                "content": art.content ?? ""
            ]
        }))
    }
    
    func pullNewsFromStore() {
        if didMount { return }
        guard let userId = authService.firebaseAuth.currentUser?.uid else { return }
        firestoreService.getFavouriteArticlesFromDocument(userId: userId, propertyName: ProperiesNames.favourites) { value in
            guard let value else {return}
            self.news = value
        }
        didMount = true
    }

    
    func addNews(item: Article) {
        news.append(item)
    }
    
    func removeNews(item: Article) {
        news.removeAll { art in
            art.title == item.title
        }
    }
}
