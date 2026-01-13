import Foundation

enum AchievementID: String, CaseIterable {
    case firstGame      = "first_game"
    case score10        = "score_10"
    case score50        = "score_50"
    case score100       = "score_100"
}

struct AchievementsData {
    static let all: [Achievement] = [
        Achievement(
            id: AchievementID.firstGame.rawValue,
            title: "First Game",
            description: "Play one game"
        ),
        Achievement(
            id: AchievementID.score10.rawValue,
            title: "Rookie",
            description: "Score 10 points"
        ),
        Achievement(
            id: AchievementID.score50.rawValue,
            title: "Pro",
            description: "Score 50 points"
        ),
        Achievement(
            id: AchievementID.score100.rawValue,
            title: "Master",
            description: "Score 100 points"
        )
    ]
    
    static let storageKey = "achievements"
}
