//
//  ResponseModels.swift
//  FleetioTest
//
//  Created by James Snelling on 9/23/25.
//

import Foundation

struct Response: Codable {
    var startCursor: String?
    var nextCursor: String?
    var perPage: Int
    var estimatedRemainingCount: Int
    var filteredBy: [Filter]
    var sortedBy: [Sort]
    var records: [VehicleRecord]
    
    enum CodingKeys: String, CodingKey {
        case startCursor = "start_cursor"
        case nextCursor = "next_cursor"
        case perPage = "per_page"
        case estimatedRemainingCount = "estimated_remaining_count"
        case filteredBy = "filtered_by"
        case sortedBy = "sorted_by"
        case records = "records"
    }
}

struct Filter: Codable {
    var name: [FilterLike]?
    var vin: [FilterLike]?
    var licensePlate: [FilterLike]?
    var externalId: [FilterLike]?
    var labels: [FilterLike]?
    var createdAt: [FilterLike]?
    var updatedAt: [FilterLike]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case vin = "vin"
        case licensePlate = "license_plate"
        case externalId = "external_id"
        case labels = "labels"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct FilterLike: Codable {
    var like: String
}

struct Sort: Codable {
    var id: String
    var name: String?
    var createdAt: String?
    var updatedAt:String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct VehicleRecord: Codable, Identifiable {
    var id: Int
    var accountId: Int
    var archivedAt: Date?
    var fuelTypeId: Int?
    var fuelTypeName: String?
    var fuelVolumeUnits: String
    var groupId: Int?
    var groupName: String?
    var name: String
    var ownership: String
    var currentLocationEntryId: Int?
    var systemOfMeasurement: String
    var isSample: Bool
    var vehicleTypeId: Int
    var vehicleTypeName: String
    var vehicleStatusId: Int
    var vehicleStatusName: String
    var vehicleStatusColor: String?
    var primaryMeterUnit: String?
    var primaryMeterValue: String?
    var primaryMeterDate: Date?
    var primaryMeterUsagePerDay: String?
    var secondaryMeterUnit: String?
    var secondaryMeterValue: String?
    var secondaryMeterDate: Date?
    var secondaryMeterUsagePerDay: String?
    var inServiceMeterValue: String?
    var inServiceDate: Date?
    var outOfServiceMeterValue: String?
    var outOfServiceDate: Date?
    var estimatedServiceMonths: Int?
    var estimatedReplacementMileage: String?
    var estimatedResalePriceCents: Int?
    var fuelEntriesCount: Int
    var serviceEntriesCount: Int
    var serviceRemindersCount: Int
    var vehicleRenewalRemindersCount: Int
    var commentsCount: Int
    var documentsCount: Int
    var imagesCount: Int
    var issuesCount: Int
    var workOrdersCount: Int
    var labels: [VehicleLabel]
    var groupAncestry: String?
    var color: String?
    var licensePlate: String?
    var vin: String?
    var year: String?
    var make: String?
    var model: String?
    var trim: String?
    var registrationExpirationMonth: Int?
    var registrationState: String?
    var defaultImageUrlSmall: String?
    var aiEnabled: Bool
    var externalIds: ExternalIds?
    var assetableType: String
    var customFields: CustomField
    var axleConfigId: Int?
    var driver: Driver
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accountId = "account_id"
        case archivedAt = "archived_at"
        case fuelTypeId = "fuel_type_id"
        case fuelTypeName = "fuel_type_name"
        case fuelVolumeUnits = "fuel_volume_units"
        case groupId = "group_id"
        case groupName = "group_name"
        case name = "name"
        case ownership = "ownership"
        case currentLocationEntryId = "current_location_entry_id"
        case systemOfMeasurement = "system_of_measurement"
        case vehicleTypeId = "vehicle_type_id"
        case vehicleTypeName = "vehicle_type_name"
        case isSample = "is_sample"
        case vehicleStatusId = "vehicle_status_id"
        case vehicleStatusName = "vehicle_status_name"
        case vehicleStatusColor = "vehicle_status_color"
        case primaryMeterUnit = "primary_meter_unit"
        case primaryMeterValue = "primary_meter_value"
        case primaryMeterDate = "primary_meter_date"
        case primaryMeterUsagePerDay = "primary_meter_usage_per_day"
        case secondaryMeterUnit = "secondary_meter_unit"
        case secondaryMeterValue = "secondary_meter_value"
        case secondaryMeterDate = "secondary_meter_date"
        case secondaryMeterUsagePerDay = "secondary_meter_usage_per_day"
        case inServiceMeterValue = "in_service_meter_value"
        case inServiceDate = "in_service_date"
        case outOfServiceMeterValue = "out_of_service_meter_value"
        case outOfServiceDate = "out_of_service_date"
        case estimatedServiceMonths = "estimated_service_months"
        case estimatedReplacementMileage = "estimated_replacement_mileage"
        case estimatedResalePriceCents = "estimated_resale_price_cents"
        case fuelEntriesCount = "fuel_entries_count"
        case serviceEntriesCount = "service_entries_count"
        case serviceRemindersCount = "service_reminders_count"
        case vehicleRenewalRemindersCount = "vehicle_renewal_reminders_count"
        case commentsCount = "comments_count"
        case documentsCount = "documents_count"
        case imagesCount = "images_count"
        case issuesCount = "issues_count"
        case workOrdersCount = "work_orders_count"
        case labels = "labels"
        case groupAncestry = "group_ancestry"
        case color = "color"
        case licensePlate = "license_plate"
        case vin = "vin"
        case year = "year"
        case make = "make"
        case model = "model"
        case trim = "trim"
        case registrationExpirationMonth = "registration_expiration_month"
        case registrationState = "registration_state"
        case defaultImageUrlSmall = "default_image_url_small"
        case aiEnabled = "ai_enabled"
        case externalIds = "external_ids"
        case assetableType = "assetable_type"
        case customFields = "custom_fields"
        case axleConfigId = "axle_config_id"
        case driver = "driver"
    }
}

struct VehicleLabel: Codable {
    var id: Int
    var name: String
}

struct CustomField: Codable {
    
}

struct Driver: Codable {
    
}

struct ExternalIds: Codable {
    
}
