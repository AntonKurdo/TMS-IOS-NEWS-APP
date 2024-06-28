import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var vm: FavouritesViewModel
    @Environment(AppSettings.self) var appSetting
    @State var navigationTitle = "Favourites"
    
    var body: some View {
        ZStack {
            if vm.news.isEmpty {
                VStack {
                    Image(systemName: "newspaper.fill").font(.system(size: 55)).foregroundColor(.gray.opacity(0.5))
                    Spacer().frame(height: 16)
                    Text("You have no favourite news...").foregroundColor(.gray.opacity(0.5))
                }
            } else {
                ScrollView {
                    ForEach(vm.news, id: \.urlToImage) { n in
                        FavouritesListItem(newsItem: n)
                    }
                }
            }
        }
        .onAppear {
            if appSetting.locale.identifier == "ru" {
                navigationTitle = "Интересное"
            } else {
                navigationTitle = "Favourites"
            }
        }
        .navigationTitle(navigationTitle)
    }
}


struct FavouritesListItem: View {
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
