//
//  DepaturesViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/6/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class DepaturesViewController: UIViewController {
	
	@IBOutlet weak var depaturesTableView: UITableView!
	
	var depatureFlights =  [Int : [String]]()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		depaturesTableSettings()
		navigationBarUpdate()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		let network = NetworkManager()
		network.getFlightInfo(infoUrl: "https://airport.by/en/timetable/online-departure") { [weak self] flightInfo in
			self?.depatureFlights = flightInfo
			self?.depaturesTableView.reloadData()
		}
	}
	
	
	func navigationBarUpdate() {
		if #available(iOS 13.0, *) {
			let navBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithOpaqueBackground()
			navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
			navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
			navBarAppearance.backgroundColor = UIColor(red: 255/255.0, green: 59/255.0, blue: 48/255.0, alpha: 1.0)
			navigationController?.navigationBar.standardAppearance = navBarAppearance
			navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
		}
	}
	
	func depaturesTableSettings() {
		let nibName = UINib(nibName: "FlightCell", bundle: nil)
		depaturesTableView.register(nibName, forCellReuseIdentifier: "flightCell")
	}
	
}

extension DepaturesViewController: UITableViewDataSource, UITableViewDelegate {
	
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
		nextViewController.flight.status = depatureFlights[indexPath.row]![6]
		nextViewController.flight.destination = depatureFlights[indexPath.row]![3]
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}
