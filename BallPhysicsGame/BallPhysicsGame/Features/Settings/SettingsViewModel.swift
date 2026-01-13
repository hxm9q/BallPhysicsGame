import Foundation
import Combine

final class SettingsViewModel: BaseViewModel {
    
    @Published var state: ViewState = .idle
    
    func onAppear() {
        Logger.log(.info, "Settings appeared")
    }
    
}
