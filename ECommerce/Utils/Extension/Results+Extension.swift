//
//  Results+Extension.swift
//  ECommerce
//
//  Created by mert can çifter on 29.02.2024.
//

import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] where T: Object {
        return compactMap { $0 as? T }
    }
}
