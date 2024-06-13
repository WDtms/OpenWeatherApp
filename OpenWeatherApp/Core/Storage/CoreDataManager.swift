//
//  CoreDataManager.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 13.06.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OpenWeatherDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addNewLocation(newLoc: CityViewModel) {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CoordinatesCoreDataModel> = CoordinatesCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", newLoc.name)
        
        do {
            let existingLocations = try context.fetch(fetchRequest)
            for location in existingLocations {
                context.delete(location)
            }
        } catch {
            print("Failed to fetch locations: \(error)")
        }
        
        let newDataModel = CoordinatesCoreDataModel(context: context)
        
        newDataModel.latitude   = newLoc.latitude
        newDataModel.longitude  = newLoc.longitude
        newDataModel.name       = newLoc.name
        newDataModel.createdAt  = Date()
        
        let fetchRequesList: NSFetchRequest<CoordinatesCoreDataModel>  = CoordinatesCoreDataModel.fetchRequest()
        fetchRequesList.sortDescriptors                                = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            let locations = try context.fetch(fetchRequesList)
            
            if locations.count > 3 {
                if let locationToDelete = locations.last {
                    context.delete(locationToDelete)
                }
            }
        } catch {
            // do nothing
        }
        
        saveContext()
    }
    
    func fetchLastSearchedLocations() -> [CityViewModel] {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CoordinatesCoreDataModel>  = CoordinatesCoreDataModel.fetchRequest()
        fetchRequest.sortDescriptors                                = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            let locations = try context.fetch(fetchRequest)
            
            return locations.map {
                CityViewModel(name: $0.name ?? "Unknown Location", latitude: $0.latitude, longitude: $0.longitude)
            }
        } catch {
            return []
        }
    }
}
