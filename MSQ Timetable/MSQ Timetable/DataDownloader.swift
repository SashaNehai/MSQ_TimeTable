//
//  ArrivalsController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/17/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation


class DataDownloader {
	
	let network = NetworkManager()

	func retrieveNetworkData (url: String, callback: ((FlightData) -> Void)?) {
		
		network.getFlightInfo(infoUrl: url){
			[weak self] flightInfo in
			print(flightInfo)
			callback?(flightInfo)
		}
	}
	
	// TODO: flightInfo convert to FlightModel
	
	
}
