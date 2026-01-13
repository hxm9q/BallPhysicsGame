import Foundation
import Combine

final class StatsViewModel: BaseViewModel {
    
    @Published var highScore: Int = 0
    
    private let storageService = StorageService.shared
    
    func loadStats() {
        viewState = .loading
        highScore = storageService.loadHighScore()
        viewState = .loaded
    }
    
    func onAppear() {
        Logger.log(.info, "Stats appeared")
    }
    
}
