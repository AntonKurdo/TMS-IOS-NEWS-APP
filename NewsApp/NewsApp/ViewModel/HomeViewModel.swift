import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var popularNews: [Article] = []
    @Published var popularNewsLoading: Bool
    
    let newsCategories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    @Published var categoryNews: [Article] = []
    @Published var categoryNewsLoading: Bool
    @Published var activeCategory: String
    
    private let api = NewsApi.shared
    
    init() {
        popularNewsLoading = true
        categoryNewsLoading = true
        activeCategory = newsCategories[0]
    }
    
    func fetchPopularNews(alerter: Alerter) {
        popularNewsLoading = true
        api.fetchNews { news in
            self.popularNews = news
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.popularNewsLoading = false
            }
        } errorHandler: { error in
            alerter.alert = Alert(title: Text("Error"), message: Text(error.localizedDescription))
            self.popularNewsLoading = false
        }
    }
    
    func fetchCategoryNews(alerter: Alerter) {
        categoryNewsLoading = true
        api.fetchNews(queryParams: "/top-headlines/category/\(activeCategory)/us.json") { news in
            self.categoryNews = news
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.categoryNewsLoading = false
            }
        } errorHandler: { error in
            alerter.alert = Alert(title: Text("Error"), message: Text(error.localizedDescription))
            self.categoryNewsLoading = false
        }
    }
    
}
