import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
