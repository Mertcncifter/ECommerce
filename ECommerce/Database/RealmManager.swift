//
//  RealmManager.swift
//  ECommerce
//
//  Created by mert can çifter on 26.02.2024.
//

import RealmSwift
import Foundation

class RealmManager {
    
    static let shared = RealmManager()

    func readAll<T: Object>(_ type: T.Type) -> Results<T>? {
        if !isRealmAccessible() { return nil }

        let realm = getRealm()
        realm.refresh()

        return realm.objects(T.self)
    }
    
    func read<T: Object>(_ type: T.Type, predicate: NSPredicate) -> T? {
        if !isRealmAccessible() { return nil }

        let realm = getRealm()
        realm.refresh()

        return realm.objects(type).filter(predicate).first
    }

    func create<T: Object>(_ data: T) {
        if !isRealmAccessible() { return }

        let realm = getRealm()
        realm.refresh()
        
        do {
            try realm.write({
                realm.add(data)
            })
        } catch let error {
            
        }
    }
    
    func update<T: Object>(_ data: T, with dictionary: [String: Any?]) {
        if !isRealmAccessible() { return }

        let realm = getRealm()
        realm.refresh()
        
        do {
            try realm.write({
                for (key, value) in dictionary {
                    data.setValue(value, forKey: key)
                }
            })
        } catch let error {
            
        }
    }

    func delete<T: Object>(_ data: T) {
        let realm = getRealm()
        realm.refresh()
        try? realm.write { realm.delete(data) }
    }

    func clearAllData() {
        if !isRealmAccessible() { return }

        let realm = getRealm()
        realm.refresh()
        try? realm.write { realm.deleteAll() }
    }
}

extension RealmManager {
    
    func getRealm() -> Realm {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("commerce.realm")


        do {
            let configuration = Realm.Configuration(fileURL: fileURL, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, objectTypes: nil)
            
            return try Realm(configuration: configuration)
        } catch let error {
            fatalError("Failed to open Realm: \(error.localizedDescription)")
        }
    }
    
    private func isRealmAccessible() -> Bool {
        do { _ = try Realm() } catch {
            print("Realm is not accessible")
            return false
        }
        return true
    }
}

