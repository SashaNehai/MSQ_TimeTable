//
//  APIService.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/4/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocols
protocol AirportAPIService {
    func parseDepatures() -> Single<[FlightDetail]>
    func parseArrivals() -> Single<[FlightDetail]>
}

// MARK: - Protocols
class AirportAPIServiceImpl {
    let api = AirpotAPI()
}

extension AirportAPIServiceImpl: AirportAPIService {
    
    func parseDepatures() -> Single<[FlightDetail]> {
        return  Single<[FlightDetail]>.create { (single) -> Disposable in
            
            self.api.depatures { (data, error) in
                if let error = error {
                    single(.error(error))
                    
                } else {
                    guard let data = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let flights = try decoder.decode([FlightDetail].self, from: data)
                        
                        single(.success(flights))
                        
                    } catch {
                        single(.error(error))
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    
    func parseArrivals() -> Single<[FlightDetail]> {
        return  Single<[FlightDetail]>.create { (single) -> Disposable in
            
            self.api.arrivals { (data, error) in
                if let error = error {
                    single(.error(error))
                    
                } else {
                    guard let data = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let flights = try decoder.decode([FlightDetail].self, from: data)
                        
                        single(.success(flights))
                        
                    } catch {
                        single(.error(error))
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    
}

