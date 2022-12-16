//
//  NetworkManagerHelper.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import Foundation
import Moya

extension NetworkManager {

    func wines(typeOfWine: TypeOfWineEnum ,completion: (([WineModel]?, Error?) -> Void)?) {
        let winesRequest = TypesOfWine.wine(type: typeOfWine)
        doRequest(target: MultiTarget(winesRequest), completion: completion)
    }
}
