//
//  CoordinatesCoreDataModel+CoreDataProperties.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 13.06.2024.
//
//

import Foundation
import CoreData


extension CoordinatesCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordinatesCoreDataModel> {
        return NSFetchRequest<CoordinatesCoreDataModel>(entityName: "CoordinatesCoreDataModel")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?

}

extension CoordinatesCoreDataModel : Identifiable {

}
