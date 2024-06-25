import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var alerter: Alerter
    
    @State var viewDidMount = false
    
    @ObservedObject var vm: HomeViewModel = HomeViewModel()
    
    private func fetchAllData() {
        vm.fetchPopularNews(alerter: alerter)
        vm.fetchCategoryNews(alerter: alerter)
    }
    
    var body: some View {
        ScrollView {
            PopularNews(news: $vm.popularNews, loading: $vm.popularNewsLoading)
            Spacer().frame(height: 32)
            CategoryNews(newsCategories: vm.newsCategories, news: $vm.categoryNews, loading: $vm.categoryNewsLoading, activeCategory: $vm.activeCategory)
        }
        .refreshable {
            fetchAllData()
        }
        .contentMargins(.bottom, 75)
        .onChange(of: vm.activeCategory, { _, _ in
            vm.fetchCategoryNews(alerter: alerter)
        })
        .onAppear {
            if !viewDidMount {
                fetchAllData()
                viewDidMount = true
            }
        }
    }
}
