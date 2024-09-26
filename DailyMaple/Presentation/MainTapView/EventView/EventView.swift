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
        List {
            ForEach(viewModel.output.events, id: \.notice_id) { event in
                VStack(alignment:. leading) {
                    Text(event.title)
                        .font(.mapleBold16)
                        .padding(.vertical)
                    Text(event.url)
                    Text("\(event.date_event_start.split(separator: "T")[0]) ~ \(event.date_event_end.split(separator: "T")[0])")
                        .font(.mapleLight14)
                }
            }
        }
    }
}

#Preview {
    EventView()
}
