//
//  ViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 12/28/19.
//  Copyright © 2019 AlexanderNehai. All rights reserved.
//

import UIKit


class ArrivalsViewController: UIViewController {
	
	@IBOutlet weak var arrivalsTableView: UITableView!
	
	var flights = [String]()
	
	//	"https://airport.by/en/timetable/online-arrival"
	//	"https://airport.by/en/timetable/online-departure"
	
	
	
	override func viewDidLoad() {
	   super.viewDidLoad()
		arrivalsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "arrivalCell")

		let network = NetworkManager()
	   network.getFlightInfo(infoUrl: "https://airport.by/en/timetable/online-arrival") { flightInfo [weak self] in
		  self?.flightInfo = flightInfo
		  self?.tableView.reloadData()
	   }
	}
	
	
	
}

extension ArrivalsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return flights.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = arrivalsTableView.dequeueReusableCell(withIdentifier: "arrivalCell", for: indexPath)
		cell.textLabel?.text = flightInfo[indexPath.row]
		return cell
	}
}
