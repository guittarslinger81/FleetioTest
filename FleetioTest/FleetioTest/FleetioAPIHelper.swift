//
//  FleetioAPIHelper.swift
//  FleetioTest
//
//  Created by James Snelling on 9/23/25.
//
import Foundation

struct FleetioAPIHelper {
    let baseURL: String = "https://secure.fleetio.com/api/vehicles"
    let accountId: String = "0a04d8629e"
    let apiToken: String = "f847df896962ac27003fc214b9e2be6dab2eea0b"
    
    func getVehicles() -> URLRequest {
        guard let url = URL(string: baseURL) else { return URLRequest(url: URL(string: baseURL)!) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Token \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue(accountId, forHTTPHeaderField: "Account-Token")
        return request
    }
    
    func getNextPage(startCursor: String) -> URLRequest {
        let urlString = "\(baseURL)start_cursor=\(startCursor)"
        guard let url = URL(string: urlString) else { return URLRequest(url: URL(string: urlString)!) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Token \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue(accountId, forHTTPHeaderField: "Account-Token")
        return request
    }
    
    func filterByName(name: String) -> URLRequest {
        let urlString = "\(baseURL)filter[name][like]=\(name)"
        guard let url = URL(string: urlString) else { return URLRequest(url: URL(string: urlString)!)}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Token \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue(accountId, forHTTPHeaderField: "Account-Token")
        return request
    }
    
}
