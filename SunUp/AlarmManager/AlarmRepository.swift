//
//  AlarmRepository.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 07/03/2022.
//

import Foundation
import CoreData

protocol AlarmRepository: ObservableObject {
    func getAlarm(with date: Date) -> Alarm?
    func set(alarm: Alarm)
    func deleteAlarm(with date: Date)
}

final class AlarmRepositoryImpl: AlarmRepository, ObservableObject {
    private let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main", managedObjectModel: Self.model)
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
            
            #if DEBUG
            if CommandLine.arguments.contains("enable-testing") {
                self.deleteAll()
            }
            #endif
        }
    }
    
    func getAlarm(with date: Date) -> Alarm? {        
        let request = AlarmDTO.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", date as NSDate)
        
        let alarmDTO = try? container.viewContext.fetch(request).first
        return Alarm(dto: alarmDTO)
    }
    
    func set(alarm: Alarm) {
        let dto = AlarmDTO(context: container.viewContext)
        dto.preferredDelay = Int16(alarm.preferredDelay)
        dto.date = alarm.date
        
        let dayTimeString: String
        switch alarm.type {
        case .sunrise: dayTimeString = "sunrise"
        case .sunset: dayTimeString = "sunset"
        }
        dto.type = dayTimeString
        
        save()
    }
    
    func deleteAlarm(with date: Date) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AlarmDTO")
        request.predicate = NSPredicate(format: "date = %@", date as NSDate)
        let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        _ = try? container.viewContext.execute(batchRequest)
    }
}

// MARK: - Setup {

extension AlarmRepositoryImpl {
    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "Main", withExtension: "momd") else {
            fatalError("Failed to locate model file.")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model file.")
        }
        
        return managedObjectModel
    }()

    /// Saves our Core Data context iff there are changes. This silently ignores
    /// any errors caused by saving, but this should be fine because our
    /// attributes are optional.
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: AlarmDTO) {
        container.viewContext.delete(object)
    }
}

// MARK: - Debug

#if DEBUG
extension AlarmRepositoryImpl {
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AlarmDTO.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? container.viewContext.execute(batchDeleteRequest)
    }
    
    func createSampleData() throws {
        let viewContext = container.viewContext

        let sunsetAlarm = AlarmDTO(context: viewContext)
        sunsetAlarm.date = Date()
        sunsetAlarm.type = "sunset"
        sunsetAlarm.preferredDelay = 0
        
        let sunriseAlarm = AlarmDTO(context: viewContext)
        sunriseAlarm.date = Date()
        sunriseAlarm.type = "sunrise"
        sunriseAlarm.preferredDelay = 0
        
        try viewContext.save()
    }

    static var example: AlarmRepositoryImpl = {
        let alarmRepositoryImpl = AlarmRepositoryImpl(inMemory: true)
        let viewContext = alarmRepositoryImpl.container.viewContext

        do {
            try alarmRepositoryImpl.createSampleData()
        } catch {
            fatalError("Fatal error creating preview \(error.localizedDescription)")
        }

        return alarmRepositoryImpl
    }()
}
#endif
