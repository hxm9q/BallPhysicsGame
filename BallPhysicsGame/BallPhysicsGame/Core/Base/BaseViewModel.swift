import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    @Published var viewState: ViewState = .idle
    @Published var error: AppError? = nil
    
    func handleError(_ error: Error) {
        self.error = AppError(from: error)
        viewState = .error
    }
    
}
