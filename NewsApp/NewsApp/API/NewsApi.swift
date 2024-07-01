import Foundation
import Alamofire

class NewsApi {
    static let shared = NewsApi()
    
    private init() {}
    
    private let baseUrl = "https://saurav.tech/NewsAPI"
    
    private let queue = DispatchQueue(label: "com.newsify.api")
    
    func fetchNews(queryParams: String = "/everything/cnn.json", completionHandler: @escaping ([Article]) -> Void, errorHandler: @escaping (_ error: Error) -> Void ) {
        AF.request("\(self.baseUrl)\(queryParams)").responseDecodable(of: NewsResponse.self, queue: queue) {response in
            switch response.result{
            case .success(let json):
                DispatchQueue.main.async {
                    completionHandler(json.articles)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    errorHandler(error)
                }
            }
        }
    }
}
