//
//  VehicleDetailView.swift
//  FleetioTest
//
//  Created by James Snelling on 9/23/25.
//

import SwiftUI

struct VehicleDetailView: View {
    var vehicle: VehicleRecord
    var notAvailable = "Not available"
    
    var body: some View {
        VStack {
            Text("\(vehicle.name) Details")
                .font(.largeTitle)
            Spacer()
            AsyncImage(url: URL(string: vehicle.defaultImageUrlSmall ?? "https://d8g9nhlfs6lwh.cloudfront.net/security=policy:eyJoYW5kbGUiOiJwVVJBZWdyY1NUT3E4ZEwwa1dvbCIsImV4cGlyeSI6NDUzNDk0OTM0MywiY2FsbCI6WyJyZWFkIiwiY29udmVydCJdfQ==,signature:452da8ad2dfe8631a5a7aac3c553c98c9cdd5072cacf6a2893104ed0cda744a8/resize=w:150,h:150,fit:crop/cache=expiry:max/rotate=exif:true/pURAegrcSTOq8dL0kWol")) { phase in
                if let image = phase.image {
                    image.resizable()
                    } else if phase.error != nil {
                        Color.pink
                    } else {
                        Color.gray
                    }
            }
            .frame(width:300, height:300)
            Spacer()
            LabeledContent {
                Text(vehicle.primaryMeterValue ?? notAvailable)
            } label: {
                Text("Primary Meter: ")
            }
            LabeledContent {
                Text(vehicle.secondaryMeterValue ?? notAvailable)
            } label: {
                Text("Secondary Meter: ")
            }
            LabeledContent {
                Text(vehicle.vin ?? notAvailable)
            } label: {
                Text("VIN Number: ")
            }
            LabeledContent {
                Text(vehicle.ownership)
            } label: {
                Text("Ownership: ")
            }
            LabeledContent {
                Text(vehicle.fuelTypeName ?? notAvailable)
            } label: {
                Text("Fuel Type: ")
            }
            LabeledContent {
                Text(vehicle.vehicleStatusName ?? notAvailable)
            } label: {
                Text("Vehicle Status: ")
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    
}
