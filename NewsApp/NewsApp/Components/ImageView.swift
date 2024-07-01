import SwiftUI

struct ImageView: View {
    
    var url: String = ""
    var contentMode: ContentMode  = .fill
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } placeholder: {
            ProgressView()
        }
    }
}
