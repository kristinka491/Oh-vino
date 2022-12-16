//
//  LResponse.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import Foundation

struct LResponse<T: Decodable> {
    var object: T?
    var data: Any?
    var error: NSError?
}

