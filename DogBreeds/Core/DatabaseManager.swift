//
//  DatabaseManagerr.swift
//  DogBreeds
//
//  Created by Bola Fayez on 01/11/2022.
//

import Foundation
import CoreData

final class DatabaseManager {

    // MARK: - Properties
    public static let sharedInstance = DatabaseManager()
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DogBreeds")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - mkRequest
    private func mkRequest<T>(type: T.Type, fetchOffset: Int = 0, fetchLimit: Int = 0, fetchBatchSize: Int = 0, sortDescriptors: [NSSortDescriptor]? = nil) -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>(entityName: NSStringFromClass(type))
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        request.fetchOffset = fetchOffset
        request.fetchBatchSize = fetchBatchSize

        return request
    }
    
    // MARK: - createManagedObject
    func createManagedObject<T: NSManagedObject>(of type: T.Type, temporary: Bool = false) -> T {
        var managedObject: T!

        context.performAndWait {
            guard !temporary else {
                managedObject = T(entity: T.entity(), insertInto: nil)
                return
            }

            managedObject = T(context: self.context)
        }

        return managedObject
    }

}

// MARK: - Predicate
extension DatabaseManager {
    enum KPPredicate<R, E> {
        case smaller(KeyPath<R, E>, E)
        case smallerOrEquals(KeyPath<R, E>, E)
        case greater(KeyPath<R, E>, E)
        case greaterOrEquals(KeyPath<R, E>, E)
        case equals(KeyPath<R, E>, E)
        case notEqual(KeyPath<R, E>, E)

        private var props: (operator: NSComparisonPredicate.Operator, keyPath: KeyPath<R, E>, value: E) {
            switch self {
            case .smaller(let kp, let value):
                return (.lessThan, kp, value)
            case .smallerOrEquals(let kp, let value):
                return (.lessThanOrEqualTo, kp, value)
            case .greater(let kp, let value):
                return (.greaterThan, kp, value)
            case .greaterOrEquals(let kp, let value):
                return (.greaterThanOrEqualTo, kp, value)
            case .equals(let kp, let value):
                return (.equalTo, kp, value)
            case .notEqual(let kp, let value):
                return (.notEqualTo, kp, value)
            }
        }

        var predicate: NSPredicate {
            let p = props
            return NSComparisonPredicate(leftExpression: NSExpression(forKeyPath: p.keyPath),
                                         rightExpression: NSExpression(forConstantValue: p.value),
                                         modifier: .direct,
                                         type: p.operator)
        }
    }
}

// MARK: - Load
extension DatabaseManager {
    
    func getAllEntries<T: NSManagedObject>(of type: T.Type, fetchOffset: Int = 0, fetchLimit: Int = 0, fetchBatchSize: Int = 0, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        loadAllEntries(of: type, predicate: Optional<KPPredicate<T, Never>>.none, fetchOffset: fetchOffset, fetchLimit: fetchLimit, fetchBatchSize: fetchBatchSize, sortDescriptors: sortDescriptors)
    }
    
    func loadAllEntries<T: NSManagedObject, V>(of type: T.Type, predicate: KPPredicate<T, V>? = nil, fetchOffset: Int = 0, fetchLimit: Int = 0, fetchBatchSize: Int = 0, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = mkRequest(type: type, fetchOffset: fetchOffset, fetchLimit: fetchLimit, fetchBatchSize: fetchBatchSize, sortDescriptors: sortDescriptors)
        request.predicate = predicate?.predicate

        var entries: [T]!

        context.performAndWait { [unowned self] in
            do {
                entries = try self.context.fetch(request)
            } catch {
                entries = []
                print("Could not fetch data for type \(type.debugDescription()): \(error.localizedDescription)")
            }
        }

        return entries
    }
    
}

// MARK: - Save
extension DatabaseManager {

    func save() {
        save(context: context)
    }

    private func save(context: NSManagedObjectContext) {
        context.performAndWait {
            guard context.hasChanges else { return }

            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
