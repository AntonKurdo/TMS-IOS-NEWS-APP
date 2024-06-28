import SwiftUI

struct DetailsView: View {
    var newsItem: Article
    
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
                VStack {
                    HStack {
                        Text(newsItem.author).foregroundStyle(.gray).font(.system(size: 14))
                        Spacer()
                        Text(DateFormatUtil.dateISOToString(newsItem.publishedAt)).foregroundStyle(.gray).font(.system(size: 14))
                    }
                    Spacer().frame(height: 12)
                    Text(newsItem.title).font(.title)
                    Spacer().frame(height: 32)
                    Text(newsItem.description).font(.system(size: 20))
                }.padding()
            }
        }
    }
}

