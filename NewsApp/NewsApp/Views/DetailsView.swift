import SwiftUI

struct DetailsView: View {
    var newsItem: Article
    
    @EnvironmentObject var sharedFavouritesVM: FavouritesViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private enum CoordinateSpaces {
        case scrollView
    }
    
    var body: some View {
        ScrollView {
            ParallaxHeader(
                coordinateSpace: CoordinateSpaces.scrollView,
                defaultHeight: 400
            ) {
                if let url = newsItem.urlToImage {
                    ZStack {
                        ImageView(url: url)
                        Color(.black.withAlphaComponent(0.3))
                    }
                }
            }
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white)
                    .frame(height: UIScreen.main.bounds.height * 0.7)
                    .coordinateSpace(name: CoordinateSpaces.scrollView)
                    .edgesIgnoringSafeArea(.vertical)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            if (sharedFavouritesVM.news.contains {$0.title == newsItem.title})  {
                                sharedFavouritesVM.removeNews(item: newsItem)
                            } else {
                                sharedFavouritesVM.addNews(item: newsItem)
                            }
                            
                        } label: {
                            ZStack {
                                Circle().frame(width: 64, height: 64)
                                Image(systemName: sharedFavouritesVM.news.contains {$0.title == newsItem.title} ?  "heart.fill" : "heart").font(.system(size: 32)).foregroundColor(.red)
                            }.clipShape(.circle).shadow(color: .gray, radius: 8)
                        }
                        .background(.white.opacity(0))
                        .position(CGPoint(x: UIScreen.main.bounds.width - 32 - 16, y: 0))
                        .accentColor(.white)
                    }
                VStack {
                    HStack {
                        Text(newsItem.author).foregroundStyle(.gray).font(.system(size: 14))
                        Spacer()
                        Text(DateFormatUtil.dateISOToString(newsItem.publishedAt)).foregroundStyle(.gray).font(.system(size: 14))
                    }.padding(.top, 24)
                    Spacer().frame(height: 12)
                    Text(newsItem.title).font(.title)
                    Spacer().frame(height: 32)
                    Text(newsItem.description).font(.system(size: 20))
                }.padding()
            }
        }.overlay(alignment: .topLeading) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward").foregroundColor(.white).font(.system(size: 20))
            }.padding(.leading, 16).padding(.top, 16)
        }
    }
}

