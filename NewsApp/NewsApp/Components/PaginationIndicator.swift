import SwiftUI


struct PaginationIndicator: View {
    
    var activeTint: Color = .accentColor
    var inactiveTint: Color = .accentColor.opacity(0.15)
    
    var body: some View {
        GeometryReader {
            let width = $0.size.width
            
            if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width,  scrollViewWidth > 0 {
                let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                let totalPages = Int(width / scrollViewWidth)
                
                let progress =  -minX / scrollViewWidth
                
                let activeIndex = Int(progress)
                let nextIndex = Int(progress.rounded(.awayFromZero))
                
                let indicatorProgress = progress - CGFloat(activeIndex)
                let currentPageWidth = 30 - (indicatorProgress * 30)
                let nextPageWidth = indicatorProgress * 30
                
                HStack(spacing: 10) {
                    ForEach(0..<totalPages, id: \.self) {index in
                        Capsule()
                            .fill(.clear)
                            .frame(width: 8 + (activeIndex == index ? currentPageWidth : nextIndex == index ? nextPageWidth : 0), height: 8)
                            .overlay {
                                ZStack {
                                    Capsule()
                                        .fill(inactiveTint)
                                    
                                    Capsule()
                                        .fill(activeTint)
                                        .opacity(activeIndex == index ? 1 - indicatorProgress : nextIndex == index ? indicatorProgress : 0)
                                }
                            }
                        
                    }
                }
                .frame(width: scrollViewWidth)
                .offset(x: -minX)
            }
            
         
        }
        .frame(height: 30)
    }
}
