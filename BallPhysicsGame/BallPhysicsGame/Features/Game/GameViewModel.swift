import Foundation
import SpriteKit
import Combine

class GameViewModel: BaseViewModel {
    @Published var score: Int = 0
    @Published var highScore: Int = 0
    @Published var isGameOver: Bool = false
    @Published var showGameOverAlert: Bool = false
    
    private(set) var scene: GameScene?
    private let storageService = StorageService.shared
    private let achievementService = AchievementService.shared
    
    override init() {
        super.init()
        highScore = storageService.loadHighScore()
        viewState = .idle
    }
    
    func gameScene(size: CGSize) -> SKScene {
        if let scene = scene {
            return scene
        }
        let newScene = GameScene(size: size)
        newScene.viewModel = self
        scene = newScene
        newScene.reset()
        return newScene
    }
    
    func startGame() {
        viewState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.score = 0
            self.isGameOver = false
            self.scene?.reset()
            self.viewState = .loaded
            self.achievementService.unlock(.firstGame)
        }
    }
    
    func resetGame() {
        score = 0
        isGameOver = false
        showGameOverAlert = false
        scene?.reset()
        viewState = .loaded
    }
    
    func goBackToStart() {
        score = 0
        isGameOver = false
        showGameOverAlert = false
        scene?.reset()
        viewState = .idle
    }
    
    func movePaddle(to x: CGFloat, in width: CGFloat) {
        guard let scene = scene else { return }
        scene.movePaddle(to: x, in: width)
    }
    
    func incrementScore() {
        score += 1
        scene?.increaseBallSpeed()
        if score >= 10 { achievementService.updateProgress(for: .score10, progress: Double(score) / 10 * 100) }
        if score >= 50 { achievementService.updateProgress(for: .score50, progress: Double(score) / 50 * 100) }
        if score >= 100 { achievementService.updateProgress(for: .score100, progress: Double(score) / 100 * 100) }
    }
    
    func endGame() {
        isGameOver = true
        showGameOverAlert = true
        
        Task {
            await storageService.saveHighScore(score)
            highScore = storageService.loadHighScore()
        }
        
        Logger.log(.info, "Game over with score: \(self.score)")
    }
    
}
