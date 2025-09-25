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
                    HStack {
                        
                    }
                    List(vehicleListResults) { vehicle in
                        HStack {
                            AsyncImage(url: URL(string: vehicle.defaultImageUrlSmall ?? "https://unsplash.com/photos/black-porsche-911-on-road-during-daytime-MPdl02hySb0")) { image in
                                image.image?.resizable()
                                image.image?.aspectRatio(contentMode: .fit)
                            }
                            .frame(width:100, height:100)
                            VStack(alignment: .leading) {
                                Text(vehicle.name)
                                Text(vehicle.ownership)
                                Text(vehicle.vehicleStatusName)
                                Text(vehicle.vehicleTypeName)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Vehicles")
            .task {
                do {
                    try await loadVehicleList()
                } catch {
                    errorMessage = error.localizedDescription
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
        print(vehicleListResults[0].defaultImageUrlSmall)
        startCursor = response.startCursor ?? ""
        nextPage = response.nextCursor ?? ""
        remaining = response.estimatedRemainingCount
        isLoading.toggle()
    }
    
    func loadNextPage() async throws {
        isLoading.toggle()
        let request = apiHelper.getNextPage(startCursor: nextPage)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(Response.self, from: data)
        vehicleListResults = vehicleListResults + response.records
        nextPage = response.nextCursor ?? ""
        remaining = response.estimatedRemainingCount
        isLoading.toggle()
    }
    
    func filter() async throws {
        isLoading.toggle()
        let request = apiHelper.filterByName(name: name)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(Response.self, from: data)
        vehicleListResults = response.records
        startCursor = response.startCursor ?? ""
        nextPage = response.nextCursor ?? ""
        remaining = response.estimatedRemainingCount
        isLoading.toggle()
    }
}

#Preview {
    ContentView()
}
