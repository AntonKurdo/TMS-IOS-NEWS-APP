import SwiftUI
import PhotosUI

struct Avatar: View {
    @Binding var uiImage: UIImage?
    @Binding var imageSelection: PhotosPickerItem?
    @Binding var avatarUrl: String
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color(.gray.withAlphaComponent(0.5))
                if uiImage != nil {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo").font(.largeTitle)
                }
            }
            .frame(width: 160, height: 160)
            .clipShape(.circle)
            .foregroundColor(.gray)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(
                    selection: $imageSelection,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Image(systemName: "pencil")
                    }.buttonStyle(.borderedProminent).clipShape(.circle)
            }
        }.onChange(of: imageSelection) {
            Task { @MainActor in
                if let data = try? await imageSelection?.loadTransferable(type: Data.self) {
                    if let contentType = imageSelection!.supportedContentTypes.first {
                        let url = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")")
                        try data.write(to: url)
                        self.avatarUrl = url.absoluteString
                    }
                    let image = UIImage(data:data)
                    uiImage = image
                    return
                }
            }
        }
    }
}


