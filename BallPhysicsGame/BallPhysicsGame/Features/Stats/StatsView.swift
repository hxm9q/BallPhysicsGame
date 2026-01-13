import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Stats")
        }
        .onAppear {
            viewModel.loadStats()
            viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            LoadingView()
        case .loaded:
            statsContent
        case .error:
            if let error = viewModel.error {
                ErrorView(error: error) {
                    viewModel.loadStats()
                }
            }
        }
    }
    
    private var statsContent: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Highscore")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("\(viewModel.highScore)")
                    .font(.system(size: 60, weight: .heavy, design: .rounded))
                    .foregroundStyle(.blue)
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
    
}
