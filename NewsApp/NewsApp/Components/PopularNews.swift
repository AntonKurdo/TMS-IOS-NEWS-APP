import SwiftUI
import SkeletonUI

struct PopularNews: View {
    @Binding var news: [Article]
    @Binding var loading: Bool
    
    private let newsAmountToDisplay = 9
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular News").font(.title3).fontWeight(.bold)
                Spacer()
                Button {
                    print("see all ->")
                } label: {
                    HStack {
                        Text("See All").font(.system(size: 12)).fontWeight(.bold)
                        Image(systemName: "arrow.right")
                    }
                }
            }.padding(.horizontal)
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    if(loading) {
                        ForEach(0..<3) { _ in
                            Color(.init(gray: 0.9, alpha: 1.0))
                                .skeleton(with: true, shape: .rectangle)
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    } else {
                        ForEach(news.prefix(newsAmountToDisplay), id: \.urlToImage) { n in
                            PopularNewsItem(newsItem: n)
                        }
                    }
                }
            }
            .contentMargins(.horizontal, 16)
            .scrollIndicators(.hidden)
        }
    }
}

struct PopularNewsItem: View {
    var newsItem: Article
    
    var body: some View {
        ZStack {
            if let url = newsItem.urlToImage {
                AsyncImage(url: URL(string: url)) { result in
                    result.image?.resizable()
                }
            }
            Color(.black.withAlphaComponent(0.5))
            VStack(alignment: .leading) {
                Text(newsItem.author ?? "").foregroundColor(.white).font(.caption)
                Spacer().frame(height: 3)
                Text(newsItem.title).foregroundColor(.white).font(.system(size: 16)).lineLimit(3)
            }.padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(alignment: .bottomTrailing) {
            Text(DateFormatter.dateISOToString(newsItem.publishedAt)).foregroundStyle(.white).font(.system(size: 8)).padding(.all, 8)
        }
    }
}






