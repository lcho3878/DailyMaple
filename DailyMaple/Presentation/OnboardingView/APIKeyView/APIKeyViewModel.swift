//
//  APIKeyViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import Foundation
import SwiftUI
import Combine

final class APIKeyViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        var key = ""
        let buttonTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var apiError: APIErrorResponse?
        var key = ""
    }
    
    init() {
        
        input.buttonTap
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    do {
                        let _ = try await APIManager.shared.callRequest(api: .checkAPIValidation(key: self.input.key), type: NoticesResponseModel.self)
                        DispatchQueue.main.async {
                            self.output.key = self.input.key
                        }
                    } catch {
                        self.output.apiError = error as? APIErrorResponse
                    }
                }
            }
            .store(in: &cancellables)
    }
}
