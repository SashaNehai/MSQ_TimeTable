//
//  DepaturesViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/6/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class DepaturesViewController: BaseFlightViewController {
	
	@IBOutlet weak var depaturesTableView: UITableView!
	
	var depatureFlights =  [Int : [String]]()
	let downloader = DataSaver()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setTableSettings(table: depaturesTableView)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		downloader.retrieveNetworkData(url: "https://airport.by/en/timetable/online-departure") {
			[weak self] flightData in
			self?.depatureFlights = flightData
			self?.depaturesTableView.reloadData()
		}
	}
}

extension DepaturesViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return depatureFlights.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: FlightCell = depaturesTableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as! FlightCell
		cell.cellUpdate(destination: depatureFlights[indexPath.row]![3],
						flightId: depatureFlights[indexPath.row]![2],
						airline: depatureFlights[indexPath.row]![0],
						time: depatureFlights[indexPath.row]![1],
						gate: depatureFlights[indexPath.row]![5],
						status: depatureFlights[indexPath.row]![6])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let storyBoard : UIStoryboard = UIStoryboard(name: "FlightDetails", bundle:nil)
		let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FlightDetailsViewController") as! FlightDetailsViewController
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
		nextViewController.flight.flightId = depatureFlights[indexPath.row]![2]
		nextViewController.flight.airline = depatureFlights[indexPath.row]![0]
		nextViewController.flight.time = depatureFlights[indexPath.row]![1]
		nextViewController.flight.status = FlightStatus(rawValue: depatureFlights[indexPath.row]![6])
		nextViewController.flight.destination = depatureFlights[indexPath.row]![3]
		nextViewController.flight.gate = depatureFlights[indexPath.row]![5]
	}
}
