//
//  API.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/4/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import Alamofire

typealias APIResponse = ((_ response: Data?, _ error: Error?) -> Void)

// MARK: - Protocols
protocol Arriavals {
    func arrivals(completionHandler: @escaping APIResponse)
}

protocol Depatures {
    func depatures(completionHandler: @escaping APIResponse)
}

// MARK: - AirpotAPI
class AirpotAPI { }

extension AirpotAPI: Arriavals {
    
    func arrivals(completionHandler: @escaping APIResponse) {
        AF.request(AirportAPIRouter.arrivals).validate().responseData { (response) in
            if let error = response.error {
                completionHandler(nil, error)
            } else if let data = response.data {
                completionHandler(data, nil)
            }
        }
    }
    
}

extension AirpotAPI: Depatures {
    
    func depatures(completionHandler: @escaping APIResponse) {
        AF.request(AirportAPIRouter.depatures).validate().responseData { (response) in
            if let error = response.error {
                completionHandler(nil, error)
            } else if let data = response.data {
                completionHandler(data, nil)
            }
        }
    }
    
}
