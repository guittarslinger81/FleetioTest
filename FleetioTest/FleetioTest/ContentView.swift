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
                        Spacer()
                        LabeledContent {
                            TextField("Filter by name", text: $name)
                                .onChange(of: name) { newValue in
                                    if newValue.isEmpty {
                                        Task {
                                            do {
                                                try await loadVehicleList()
                                            } catch {
                                                
                                                errorMessage = error.localizedDescription
                                                print(errorMessage)
                                            }
                                        }
                                    }
                                }
                        } label: {
                            Text("Filter")
                                .font(.headline)
                        }
                        Button("Go") {
                            Task {
                                do {
                                    try await filter()
                                } catch {
                                    
                                    errorMessage = error.localizedDescription
                                    print(errorMessage)
                                }
                            }
                        }.disabled(name.isEmpty)
                        Spacer()
                    }
                    List(vehicleListResults, id: \.self) { vehicle in
                        NavigationLink(destination: VehicleDetailView(vehicle: vehicle)) {
                            HStack {
                                AsyncImage(url: URL(string: vehicle.defaultImageUrlSmall ?? "https://d8g9nhlfs6lwh.cloudfront.net/security=policy:eyJoYW5kbGUiOiJwVVJBZWdyY1NUT3E4ZEwwa1dvbCIsImV4cGlyeSI6NDUzNDk0OTM0MywiY2FsbCI6WyJyZWFkIiwiY29udmVydCJdfQ==,signature:452da8ad2dfe8631a5a7aac3c553c98c9cdd5072cacf6a2893104ed0cda744a8/resize=w:150,h:150,fit:crop/cache=expiry:max/rotate=exif:true/pURAegrcSTOq8dL0kWol")) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                        } else if phase.error != nil {
                                            Color.pink
                                        } else {
                                            Color.gray
                                        }
                                }
                                .frame(width:100, height:100)
                                VStack(alignment: .leading) {
                                    LabeledContent {
                                        Text(vehicle.name ?? "Not available")
                                    } label: {
                                        Text("Name: ")
                                    }
                                    LabeledContent {
                                        Text(vehicle.make ?? "Not available")
                                    } label: {
                                        Text("Make: ")
                                    }
                                    LabeledContent {
                                        Text(vehicle.model ?? "Not available")
                                    } label: {
                                        Text("Model: ")
                                    }
                                    LabeledContent {
                                        Text(vehicle.licensePlate ?? "Not available")
                                    } label: {
                                        Text("Plate: ")
                                    }
                                    LabeledContent {
                                        Text(vehicle.vehicleTypeName ?? "Not available")
                                    } label: {
                                        Text("Type: ")
                                    }
                                }
                                .onAppear {
                                    if vehicle == vehicleListResults.last && nextPage != "" {
                                        Task {
                                            do {
                                                try await loadNextPage()
                                            } catch {
                                                
                                                errorMessage = error.localizedDescription
                                                print(errorMessage)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    .navigationTitle("Vehicle Details")
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
        print(response)
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
