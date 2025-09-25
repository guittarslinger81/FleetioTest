//
//  ContentView.swift
//  FleetioTest
//
//  Created by James Snelling on 9/23/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var vehicleListResults = [VehicleRecord]()
    private var apiHelper = FleetioAPIHelper()
    private var nextPage: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func loadVehicleList() {
        
    }
    
    func loadNextPage() {
        
    }
    
    func filter() {
        
    }
}

#Preview {
    ContentView()
}
