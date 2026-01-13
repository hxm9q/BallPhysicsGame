import Foundation

@MainActor
class StorageService {
    
    static let shared = StorageService()
    
    private let highScoreKey = "highScore"
    
    func loadHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: highScoreKey)
    }
    
    func saveHighScore(_ score: Int) async {
        let currentHighScore = loadHighScore()
        if score > currentHighScore {
            UserDefaults.standard.set(score, forKey: highScoreKey)
        }
    }
    
}
