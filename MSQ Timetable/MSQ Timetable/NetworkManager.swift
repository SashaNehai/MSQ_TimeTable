//
//  NetworkManager.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 12/28/19.
//  Copyright © 2019 AlexanderNehai. All rights reserved.
//

import Foundation

class NetworkManager {
	
	func getFlightInfo(infoUrl: String, callBack: (([Int : [String]]) -> Void)?) {
		var flightInfo = [Int : [String]]()
		let url = URL(string: infoUrl)!
		let request = URLRequest(url: url)
		
		let task = URLSession.shared.dataTask(with: request as URLRequest) {
			data, response, error in
			
			if error != nil{
				print(error!)
			} else {
				
				if let unwrappedData = data {
					
					let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
					let separator = """
						</div>
						<!-- /block -->
						"""
					
					if let dataUpdated = dataString?.components(separatedBy: separator) {
						let data = dataUpdated[4].components(separatedBy: "</tr><tr class=")
						var todayFlights = [String]()
						
						for element in data {
							if element.contains("today") {
								todayFlights.append(element)
							}
						}
						
						var flightKey = 0
						for flight in todayFlights {
							let info = flight.components(separatedBy: "</td><td>")
							var infoUpdated = [String]()
							
							for element in info {
								if element.contains("today><td>") {
									infoUpdated.append(contentsOf: element.components(separatedBy: "today><td>"))
								} else {
									infoUpdated.append(element)
								}
							}
							infoUpdated.remove(at: 0)
							
							for (index, element) in infoUpdated.enumerated() {
								
								if element.contains("<span style="){
									if element.contains("ARRIVED"){
										infoUpdated.remove(at: index)
										infoUpdated.append("ARRIVED")
									} else if element.contains("LANDED") {
										infoUpdated.remove(at: index)
										infoUpdated.append("LANDED")
									} else if element.contains("EN ROUTE") {
										infoUpdated.remove(at: index)
										infoUpdated.append("EN ROUTE")
									} else if element.contains("DELAYED") {
										infoUpdated.remove(at: index)
										infoUpdated.append("DELAYED")
									} else if element.contains("AIRBORNE") {
										infoUpdated.remove(at: index)
										infoUpdated.append("AIRBORNE")
									} else if element.contains("BOARDING") {
										infoUpdated.remove(at: index)
										infoUpdated.append("BOARDING")
									} else if element.contains("CHECK-IN") {
										infoUpdated.remove(at: index)
										infoUpdated.append("CHECK-IN")
									} else if element.contains("CANCELLED") {
										infoUpdated.remove(at: index)
										infoUpdated.append("CANCELLED")
									}
									
								} else if element.contains("</td>"){
									infoUpdated.remove(at: index)
									infoUpdated.append("")
								}
							}
							flightInfo[flightKey] = infoUpdated
							flightKey += 1
						}
						print("flights: \(flightInfo.sorted{ $0.key < $1.key })")
					}
				}
			}
			DispatchQueue.main.sync(execute: {
				callBack?(flightInfo)
			})
		}
		task.resume()
		return 
	}
}
