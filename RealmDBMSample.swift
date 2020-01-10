//
//  RealmDatabaseManager.swift
//  EmergencyCall_Swift
//
//  Created by Francis Jemuel Bergonia on 1/6/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//


import Foundation
import RealmSwift

class RealmDatabaseManager {
    static let realm = try! Realm()
    
    
    //MARK: Memo Methods
    static func getAllMemos() -> Results<Memo>? {
        var photos: Results<Memo>?
        photos = realm.objects(Memo.self)
        let sortedPhotos = photos?.sorted(byKeyPath: "photoName", ascending: true)
        return sortedPhotos
    }
    
    static func save(_ object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error Saving Object: \(error.localizedDescription)")
        }
    }
    
    static func update(_ object: Object) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("Error Saving Object: \(error.localizedDescription)")
        }
    }
    
    static func delete(_ object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error Deleting Object: \(error.localizedDescription)")
        }
    }
    
    static func fetch(key: String) -> SaveItem? {
        
        if let fetchResult = realm.objects(SaveItem.self).filter("key = '\(key)'" ).first {
            return SaveItem(key: fetchResult.key, value: fetchResult.value)
        }
        print("Error Fetching Object or Object doesnt yet exist")
        return nil
    }
}



