//
//  SearchTabViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 10/3/24.
//

import Foundation
import Combine

final class SearchTabViewModel: ObservableObject {
    
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
        var isActive = false
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
                            self.output.isActive = true
                        }
                    } catch {
                        self.output.apiError = error as? APIErrorResponse
                    }
                }
            }
            .store(in: &cancellables)
    }
}
