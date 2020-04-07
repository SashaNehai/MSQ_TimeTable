//
//  APIRouter.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/4/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - AirportAPIRouter
enum AirportAPIRouter {
    case arrivals
    case depatures
    
    static var baseURLString = "https://airport.by/en/flights/"
    
    var method: HTTPMethod {
        switch self {
        case .arrivals:
            return .get
        case .depatures:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .arrivals:
            return "arrival"
        case .depatures:
            return "departure"
        }
    }
    
}

// MARK: - URLRequestConvertible
extension AirportAPIRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try AirportAPIRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
