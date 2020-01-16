//
//  ViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 12/28/19.
//  Copyright © 2019 AlexanderNehai. All rights reserved.
//

import UIKit


class ArrivalsViewController: UIViewController, UITableViewDelegate {
	
	@IBOutlet weak var arrivalsTableView: UITableView!
	
	var arrivalFlights =  [Int : [String]]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		arrivalsTableSettings()
		navigationBarUpdate()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		let network = NetworkManager()
		network.getFlightInfo(infoUrl: "https://airport.by/en/timetable/online-arrival") { [weak self] flightInfo in
			self?.arrivalFlights = flightInfo
			self?.arrivalsTableView.reloadData()
		}
	}
	
	func arrivalsTableSettings() {
		let nibName = UINib(nibName: "FlightCell", bundle: nil)
		arrivalsTableView.register(nibName, forCellReuseIdentifier: "flightCell")
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
		nextViewController.flight.status = arrivalFlights[indexPath.row]![6]
		nextViewController.flight.destination = arrivalFlights[indexPath.row]![4]
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
}
