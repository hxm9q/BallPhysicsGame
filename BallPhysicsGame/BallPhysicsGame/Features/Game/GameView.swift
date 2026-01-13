import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Game")
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .idle:
            startButton
        case .loading:
            LoadingView()
        case .loaded:
            gameContent
        case .error:
            if let error = viewModel.error {
                ErrorView(error: error) {
                    viewModel.resetGame()
                }
            }
        }
    }
    
    private var startButton: some View {
        Button("Start Game") {
            viewModel.startGame()
        }
        .font(.largeTitle)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
    }
    
    private var gameContent: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Score: \(viewModel.score)")
                    .font(.headline)
                Spacer()
                Text("Highscore: \(viewModel.highScore)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            
            GeometryReader { geometry in
                SpriteView(scene: viewModel.gameScene(size: geometry.size))
                    .ignoresSafeArea()
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                viewModel.movePaddle(to: value.location.x, in: geometry.size.width)
                            }
                    )
            }
        }
        .alert("Game over", isPresented: $viewModel.showGameOverAlert) {
            Button("Try again") {
                viewModel.resetGame()
            }
            Button("Go back", role: .cancel) {
                viewModel.goBackToStart()
            }
        } message: {
            Text("Your score: \(viewModel.score)")
        }
    }
    
}
