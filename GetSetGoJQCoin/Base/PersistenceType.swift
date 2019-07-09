//
//  PersistenceType.swift
//  Sipradi
//
//  Created by Dari on 6/8/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmPersistenceType {
    var realmObject: Realm {get}
    
    func save(models: [Object])
    
    func deleteAll<T: Object>(ofType: T.Type)
    
    func fetch<T: Object>() -> [T]
    
    func fetch<T: Object>(primaryKey: Any) -> T?
    
    func changeModels(action: ()->())
    
    func delete(models: [Object])
    
    func deleteAll()
    
}

extension RealmPersistenceType {
    var realmObject: Realm {
        return realm
    }
    
    func save(models: [Object]) {
        let realm = try! Realm()
        try! realm.write {
            realmObject.add(models, update: true)
        }
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteAll<T: Object>(ofType: T.Type) {
        let realm = try! Realm()
        let objects: [T] = self.fetch()
        
        realmObject.beginWrite()
        do {
            realm.delete(objects)
            try realm.commitWrite()
        } catch {
            if realm.isInWriteTransaction { realm.cancelWrite() }
        }
    }
    
    func fetch<T: Object>() -> [T] {
        let realm = try! Realm()
        let values = realm.objects(T.self)
        return Array(values)
    }
    
    func fetch<T: Object>(filter: String) -> [T] {
        let realm = try! Realm()
        let values = realm.objects(T.self).filter(filter)
        return Array(values)
    }
    
    func fetch<T: Object>(predicates: [NSPredicate] = [], filters: [String] = []) -> [T] {
        let realm = try! Realm()
        var values = predicates.reduce(realm.objects(T.self)) { (result, predicate) in
            return result.filter(predicate)
        }
        values = filters.reduce(values) { (result, filter) in
            return result.filter(filter)
        }
        return Array(values)
    }
    
    func fetch<T: Object>(primaryKey: Any) -> T? {
        let realm = try! Realm()
        return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    func changeModels(action: ()->()) {
        let realm = try! Realm()
        realm.beginWrite()
        do {
            action()
            try realm.commitWrite()
        } catch {
            if realm.isInWriteTransaction { realm.cancelWrite() }
        }
    }
    
    func delete(models: [Object]) {
        let realm = try! Realm()
        self.changeModels {
            realm.delete(models)
        }
    }
}

private let realm = try! Realm()
