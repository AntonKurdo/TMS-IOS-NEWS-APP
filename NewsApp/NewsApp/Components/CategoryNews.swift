import SwiftUI
import SkeletonUI

struct CategoryNews: View {
    var newsCategories: [String]
    
    @Binding var news: [Article]
    @Binding var loading: Bool
    @Binding var activeCategory: String
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(newsCategories, id: \.self) { n in
                        Button {
                            activeCategory = n
                        } label: {
                            Text(n.capitalized)
                                .frame(height: 35)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                .background(activeCategory == n ? .accent : Color.accentColor.opacity(0))
                                .foregroundColor(activeCategory == n ? .white : .black)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .stroke(Color.gray.opacity(0.8), lineWidth: activeCategory == n ? 0 : 0.5)
                                )
                                .mask {
                                    LinearGradient(colors: [.white.opacity(0.8), .white.opacity(1)], startPoint: .leading, endPoint: .trailing)
                                }
                        }
                        .disabled(loading)
                    }
                }
            }
            .contentMargins(.horizontal, 16)
            .scrollIndicators(.hidden)
            Spacer().frame(height: 16)
            VStack(spacing: 12) {
                if(loading) {
                    ForEach(0..<4) { _ in
                        Color(.init(gray: 0.9, alpha: 1.0))
                            .skeleton(with: true, shape: .rectangle)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                } else {
                    ForEach(news.prefix(9), id: \.urlToImage) { n in
                        CategoryNewsItem(newsItem: n)
                    }
                    NavigationLink(destination: {
                        NewsListView(news: news, navigationTitle: activeCategory.capitalized)
                    }) {
                        Text("See All About \(activeCategory.capitalized)").padding()
                    }
                }
            }
        }
    }
}

struct CategoryNewsItem: View {
    var newsItem: Article
    
    var body: some View {
        NavigationLink {
            DetailsView(newsItem: newsItem)
        } label: {
            ZStack(alignment: .top) {
                if let url = newsItem.urlToImage {
                    ImageView(url: url)
                }
                Color(.black.withAlphaComponent(0.5))
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .top, content: {
                Text(newsItem.title).foregroundColor(.white).font(.system(size: 16)).lineLimit(3).padding()
            })
            .overlay(alignment: .bottom) {
                HStack {
                    Text(newsItem.author ?? "").foregroundColor(.white).font(.system(size: 10))
                    Spacer()
                    Text(DateFormatUtil.dateISOToString(newsItem.publishedAt)).foregroundStyle(.white).font(.system(size: 8))
                }.padding(.all, 8)
            }
        }
        
    }
}
