
import SwiftUI

struct NewsListView: View {
    
    var news: [Article]
    
    var navigationTitle: String = ""
    
    var body: some View {
        ScrollView {
            ForEach(news, id: \.urlToImage) { n in
                NewsListItem(newsItem: n)
            }
        }
        .navigationTitle(LocalizedStringKey(navigationTitle))
    }
}

struct NewsListItem: View {
    var newsItem: Article
    
    var body: some View {
        NavigationLink(destination: DetailsView(newsItem: newsItem)) {
            VStack(alignment: .leading) {
                ZStack {
                    Color(.black.withAlphaComponent(0.5))
                    
                    if let url = newsItem.urlToImage {
                        ImageView(url: url)
                    }
                }
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(DateFormatUtil.dateISOToString(newsItem.publishedAt, format: "EEEE, d MMM YYYY")).foregroundStyle(.black).font(.system(size: 10)).frame(alignment: .leading).padding(.vertical, 2)
                Text(newsItem.title).foregroundColor(.black).font(.system(size: 16)).fontWeight(.bold).multilineTextAlignment(.leading)
                Spacer().frame(height: 8)
                Text(newsItem.title).foregroundColor(.black).font(.system(size: 13)).multilineTextAlignment(.leading)
                Spacer().frame(height: 8)
                Text(newsItem.author).foregroundColor(.black).font(.system(size: 10)).fontWeight(.bold)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.95).padding()
    }
}
