//
//  EventView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/26/24.
//

import SwiftUI

struct EventView: View {
    typealias Event = EventsResponseModel.Event
    
    @State private var viewModel = EventViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.output.events, id: \.notice_id) { event in
                        NavigationLink {
                            WebView(urlToLoad: event.mobileURL)
                        } label: {
                            VStack(alignment:. leading, spacing: 10) {
                                Text(event.title)
                                    .font(.mapleBold16)
                                Text("\(event.startDate) ~ \(event.endDate)")
                                    .font(.mapleLight14)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EventView()
}
