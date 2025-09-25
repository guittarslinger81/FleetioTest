//
//  ContentView.swift
//  FleetioTest
//
//  Created by James Snelling on 9/23/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var vehicleListResults: [VehicleRecord] = []
    private var apiHelper = FleetioAPIHelper()
    @State private var nextPage: String = ""
    @State private var startCursor: String = ""
    @State private var remaining: Int = 100
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage {
                    Text(errorMessage)
                } else {
                    List(vehicleListResults) { vehicle in
                        VStack(alignment: .leading) {
                            
                        }
                    }
                }
            }
        }
    }
    
    func loadVehicleList() async throws {
        isLoading.toggle()
        let request = apiHelper.getVehicles()
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(Response.self, from: data)
        vehicleListResults = response.records
        startCursor = response.startCursor
        nextPage = response.nextCursor
        remaining = response.estimatedRemainingCount
        isLoading.toggle()
    }
    
    func loadNextPage() async throws {
        isLoading.toggle()
        let request = apiHelper.getNextPage(startCursor: nextPage)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(Response.self, from: data)
        vehicleListResults = vehicleListResults + response.records
        nextPage = response.nextCursor
        remaining = response.estimatedRemainingCount
        isLoading.toggle()
    }
    
    func filter() async throws {
        isLoading.toggle()
        let request = apiHelper.filterByName(name: name)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(Response.self, from: data)
        vehicleListResults = response.records
        startCursor = response.startCursor
        nextPage = response.nextCursor
        remaining = response.estimatedRemainingCount
        isLoading.toggle()
    }
}

#Preview {
    ContentView()
}
