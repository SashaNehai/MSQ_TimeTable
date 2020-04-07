//
//  ArrivalsViewModel.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/6/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocols
protocol FlightsViewModel {
    var flightsObservable: Observable<[FlightDetail]> { get }
    var flightTypeObserver: AnyObserver<Int> { get }
}

// MARK: - ArrivalsViewModelImpl
class FlightsViewModelImpl {
    
    let bag = DisposeBag()
    let service = AirportAPIServiceImpl()
    
    let flightsSubject = BehaviorSubject<[FlightDetail]>(value: [])
    let flightTypeSubject = BehaviorSubject<Int>(value: 0)
    var flightTypeObservable: Observable<Int> {
        return flightTypeSubject.asObservable()
    }
    
    init() {
        getFlights()
    }
    
}

// MARK: - ArrivalsViewModel
extension FlightsViewModelImpl: FlightsViewModel {
    
    var flightsObservable: Observable<[FlightDetail]> {
        return flightsSubject.asObservable()
    }
    
    var flightTypeObserver: AnyObserver<Int> {
        return flightTypeSubject.asObserver()
    }
    
    private func getArrivals() {
        service.parseArrivals().subscribe(onSuccess: { [weak self] (flights) in
            
            let correctFlights = flights.filter { DateInteractor.isToday(date: $0.plan ?? "") }
                .map { (flight) -> FlightDetail in
                    var updatedFlight = flight
                    updatedFlight.fact = DateInteractor.time(timestamp: updatedFlight.fact ?? "")
                    updatedFlight.plan = DateInteractor.time(timestamp: updatedFlight.plan ?? "")
                    updatedFlight.eat = DateInteractor.time(timestamp: updatedFlight.eat ?? "")
                    return updatedFlight
            }
            
            self?.flightsSubject.onNext(correctFlights)
        }).disposed(by: bag)
    }
    
    private func getDepatures() {
        service.parseDepatures().subscribe(onSuccess: { [weak self] (flights) in
            
            let correctFlights = flights.filter { DateInteractor.isToday(date: $0.plan ?? "") }
                .map { (flight) -> FlightDetail in
                    var updatedFlight = flight
                    updatedFlight.fact = DateInteractor.time(timestamp: updatedFlight.fact ?? "")
                    updatedFlight.plan = DateInteractor.time(timestamp: updatedFlight.plan ?? "")
                    updatedFlight.eat = DateInteractor.time(timestamp: updatedFlight.eat ?? "")
                    return updatedFlight
            }
            
            self?.flightsSubject.onNext(correctFlights)
        }).disposed(by: bag)
    }
    
    private func getFlights() {
        flightTypeObservable.subscribe(onNext: { [weak self] (int) in
            if int == 0 {
                self?.getDepatures()
            } else {
                self?.getArrivals()
            }
        }).disposed(by: bag)
    }
    
}
