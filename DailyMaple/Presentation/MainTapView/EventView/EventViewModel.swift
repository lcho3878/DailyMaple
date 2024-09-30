//
//  EventViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/26/24.
//

import Foundation
import Combine

final class EventViewModel: ObservableObject {
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {

    }
    
    struct Output {
        var pickerOutput: TapMenu = .notices
        var notices: [Eventable] = []
        var updates: [Eventable] = []
        var events: [Eventable] = []
        var cashNotices: [Eventable] = []
    }
    
    init() {
        BuildTestManager.shared.isNetworking ? loadNoticeData() : loadNoticeMockData()
        BuildTestManager.shared.isNetworking ? loadUpdateData() : loadUpdateMockData()
        BuildTestManager.shared.isNetworking ? loadEventData() : loadEventMockData()
        BuildTestManager.shared.isNetworking ? loadCashData() : loadCashMockData()
    }
}

extension EventViewModel {
    enum TapMenu: String, CaseIterable {
        case notices = "공지사항"
        case updates = "업데이트"
        case events = "이벤트"
        case cashNotices = "캐시샵 공지"
    }
}

extension EventViewModel {
    
    private func loadNoticeMockData() {
        guard let data = MockDataManager.shared.loadData(fileName: "Notices") else { return }
        do {
            let result = try JSONDecoder().decode(NoticesResponseModel.self, from: data)
            output.notices = result.notice
            print("Notices MockData Load")
        }
        catch {
            print("Notices Error")
        }
    }
    
    private func loadNoticeData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .notices, type: NoticesResponseModel.self)
            DispatchQueue.main.async { [weak self] in
                self?.output.notices = result.notice
            }
           
            print("Notices APIData Load")
        }
    }
    
    private func loadUpdateMockData() {
        guard let data = MockDataManager.shared.loadData(fileName: "Updates") else { return }
        do {
            let result = try JSONDecoder().decode(UpdatesResponseModel.self, from: data)
            output.updates = result.update_notice
            print("Updates MockData Load")
        }
        catch {
            print("Updates Error")
        }
    }
    
    private func loadUpdateData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .updates, type: UpdatesResponseModel.self)
            DispatchQueue.main.async { [weak self] in
                self?.output.updates = result.update_notice
            }
            print("Updates APIData Load")
        }
    }
    
    private func loadEventMockData() {
        guard let data = MockDataManager.shared.loadData(fileName: "Events") else { return }
        do {
            let result = try JSONDecoder().decode(EventsResponseModel.self, from: data)
            output.events = result.event_notice
            print("Events MockData Load")
        }
        catch {
            print("Event Error")
        }
    }
    
    private func loadEventData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .events, type: EventsResponseModel.self)
            DispatchQueue.main.async { [weak self] in
                self?.output.events = result.event_notice
            }
            print("Events APIData Load")
        }
    }
    
    private func loadCashMockData() {
        guard let data = MockDataManager.shared.loadData(fileName: "Cash") else { return }
        do {
            let result = try JSONDecoder().decode(CashNoticesResponseModel.self, from: data)
            output.cashNotices = result.cashshop_notice
            print("CashNotices MockData Load")
        }
        catch {
            print("CashNotices Error\n\(error)")
        }
    }
    
    private func loadCashData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .cashUpdates, type: CashNoticesResponseModel.self)
            DispatchQueue.main.async { [weak self] in
                self?.output.cashNotices = result.cashshop_notice
            }
            print("CashNotices APIData Load")
        }
    }
}
