//
//  OcidViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import Foundation
import Combine

final class OcidViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        var nickname = ""
        let buttonTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var apiError: APIErrorResponse?
        var ocid = ""
    }
    
    init() {
        input.buttonTap
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    do {
                        let result = try await APIManager.shared.callRequest(api: .ocid(query: self.input.nickname), type: OcidResponseModel.self)
                        DispatchQueue.main.async {
                            self.output.ocid = result.ocid
                        }
                    } catch {
                        self.output.apiError = error as? APIErrorResponse
                    }
                }
            }
            .store(in: &cancellables)
    }
}
