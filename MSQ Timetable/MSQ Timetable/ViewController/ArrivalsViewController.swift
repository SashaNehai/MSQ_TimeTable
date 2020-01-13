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
	
	var arrivalFlights =  [Int : [String]]()
	
	//	"https://airport.by/en/timetable/online-arrival"
	//	"https://airport.by/en/timetable/online-departure"
	
	
	
	override func viewDidLoad() {
	   super.viewDidLoad()
		arrivalsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "arrivalCell")

		
		if #available(iOS 13.0, *) {
			let navBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithOpaqueBackground()
			navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
			navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
			navBarAppearance.backgroundColor = UIColor(red: 255/255.0, green: 59/255.0, blue: 48/255.0, alpha: 1.0)
			navigationController?.navigationBar.standardAppearance = navBarAppearance
			navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
		}
		
		
		
		let network = NetworkManager()
		network.getArrivalInfo(infoUrl: "https://airport.by/en/timetable/online-arrival") { [weak self] flightInfo in
			self?.arrivalFlights = flightInfo
			self?.arrivalsTableView.reloadData()
	   }
	}
	
	
	
}

extension ArrivalsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrivalFlights.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = arrivalsTableView.dequeueReusableCell(withIdentifier: "arrivalCell", for: indexPath)
		
		cell.textLabel?.text = arrivalFlights[indexPath.row]?[0]
		
		return cell
	}
}
