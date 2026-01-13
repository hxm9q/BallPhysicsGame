import Foundation

final class HomeViewModel: BaseViewModel {
    
    override init() {
        super.init()
        viewState = .loaded
    }
    
    func onAppear() {
        Logger.log(.info, "Home appeared")
    }
    
}
