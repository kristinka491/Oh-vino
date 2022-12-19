//
//  RealmCollection+Extension.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 19.12.2022.
//

import RealmSwift

extension RealmCollection {

    func toArray<T>() ->[T] {
        return self.compactMap { $0 as? T }
    }
}
