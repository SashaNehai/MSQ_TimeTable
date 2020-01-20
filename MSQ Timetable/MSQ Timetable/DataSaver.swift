//
//  ArrivalsController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/17/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataSaver {
	
	let network = NetworkManager()
	
	var flights: [NSManagedObject] = []
	
	func retrieveNetworkData (url: String, callback: ((FlightData) -> Void)?) {
		
		network.getFlightInfo(infoUrl: url){
			[weak self] flightInfo in
			
			// Save to DB is ready but will be implement in future
			// self?.saveFlightDataToCoreData(flightInfo: flightInfo, url: url)
			callback?(flightInfo)
		}
	}
	
	func saveFlightDataToCoreData(flightInfo: FlightData, url: String) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Flight", in: managedContext)
		
		for (_, value) in flightInfo {
			let flight = NSManagedObject(entity: entity!, insertInto: managedContext)
			flight.setValue(value[0], forKey: "airline")
			flight.setValue(value[1], forKey: "time")
			
			if url.contains("arrival") {
				// For Arrivals
				flight.setValue(value[3], forKey: "flightId")
				flight.setValue(value[4], forKey: "destination")
			} else {
				// For Depatures
				flight.setValue(value[2], forKey: "flightId")
				flight.setValue(value[3], forKey: "destination")
				flight.setValue(value[5], forKey: "gate")
			}
			
			flight.setValue(value[6], forKey: "status")
			do {
				if checkCoreData(flight.primitiveValue(forKey: "flightId") as! String) {
					// Here update existing entity attributes
					print("exist")
					continue
				} else {
					
					try managedContext.save()
					
					flights.append(flight)
					
				}
			} catch let error as NSError {
				print("Error om save to DB: \(error)")
			}
		}
	}
	
	func checkCoreData(_ flightID: String) -> Bool {
		
		var checker = false
		var recordedFlights: [NSManagedObject] = []
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
		
		let managedContext = appDelegate.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Flight")
		
		do {
			recordedFlights = try managedContext.fetch(fetchRequest)
			
			for flight in recordedFlights {
				
				if flight.value(forKey: "flightId") as! String == flightID {
					print(flight.value(forKey: "flightId").debugDescription)
					checker = true
				}
			}
			
			
		} catch let error as NSError {
			print("Error on get from DB: \(error)")
		}
		
		return checker
	}
}
