//
//  EventViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/26/24.
//

import Foundation

final class EventViewModel: ObservableObject {
    
    @Published var output = Output()
    
    struct Output {
        var events: [EventsResponseModel.Event] = []
    }
    
    init() {
        guard let data = MockDataManager.shared.loadData(fileName: "Events") else { return }
        do {
            let result = try JSONDecoder().decode(EventsResponseModel.self, from: data)
            output.events = result.event_notice
            print("Events Data Load")
        }
        catch {
            print("Evnet Error")
        }
    }
}
