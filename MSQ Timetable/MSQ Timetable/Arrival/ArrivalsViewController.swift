//
//  ViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 12/28/19.
//  Copyright © 2019 AlexanderNehai. All rights reserved.
//

import UIKit

class ArrivalsViewController: BaseFlightViewController {
	
	@IBOutlet weak var arrivalsTableView: UITableView!
	
	var arrivalFlights = FlightData()
	let downloader = DataSaver()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setTableSettings(table: arrivalsTableView)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)

		downloader.retrieveNetworkData(url: "https://airport.by/en/timetable/online-arrival") {
			[weak self] flightData in
			self?.arrivalFlights = flightData
			self?.arrivalsTableView.reloadData()
		}
	}
	
}

extension ArrivalsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrivalFlights.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: FlightCell = arrivalsTableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as! FlightCell
		
		cell.cellUpdate(destination: arrivalFlights[indexPath.row]![4],
						flightId: arrivalFlights[indexPath.row]![3],
						airline: arrivalFlights[indexPath.row]![0],
						time: arrivalFlights[indexPath.row]![2],
						gate: "",
						status: arrivalFlights[indexPath.row]![6])
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let storyBoard : UIStoryboard = UIStoryboard(name: "FlightDetails", bundle:nil)
		let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FlightDetailsViewController") as! FlightDetailsViewController
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
		nextViewController.flight.flightId = arrivalFlights[indexPath.row]![3]
		nextViewController.flight.airline = arrivalFlights[indexPath.row]![0]
		nextViewController.flight.time = arrivalFlights[indexPath.row]![2]
		nextViewController.flight.status = FlightStatus(rawValue: arrivalFlights[indexPath.row]![6])
		nextViewController.flight.destination = arrivalFlights[indexPath.row]![4]
	}
	
}
