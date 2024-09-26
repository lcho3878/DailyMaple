//
//  EventView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/26/24.
//

import SwiftUI

struct EventView: View {
    typealias Event = EventsResponseModel.Event
    
    @StateObject private var viewModel = EventViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Menu", selection: $viewModel.output.pickerOutput) {
                    ForEach(EventViewModel.TapMenu.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                List {
                    Section {
                        switch viewModel.output.pickerOutput {
                        case .notices:
                            EventListView(data: viewModel.output.notices)
                        case .updates:
                            EventListView(data: viewModel.output.updates)
                        case .events:
                            EventListView(data: viewModel.output.events)
                        case .cashNotices:
                            EventListView(data: viewModel.output.cashNotices)
                        }
                    } header: {
                        Text(viewModel.output.pickerOutput.rawValue)
                    }

                }
            }
        }
    }
    
    struct EventListView: View {
        let data: [Eventable]
        var body: some View {
            ForEach(data, id: \.notice_id) { event in
                NavigationLink {
                    WebView(urlToLoad: event.mobileURL)
                } label: {
                    VStack(alignment:. leading, spacing: 10) {
                        Text(event.title)
                            .font(.mapleBold(16))
                        HStack {
                            Text(event.startDate)
                            if let endDate = event.endDate {
                                Text(" ~ \(endDate)")
                            }
                        }
                        .font(.mapleLight(14))
                    }
                }
            }
        }
    }
}

#Preview {
    EventView()
}
