//
//  BaseFlightViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/17/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import UIKit

class BaseFlightViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setNavigationBarDesign()
	}
	
	func setNavigationBarDesign() {
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
	
	func setTableSettings(table: UITableView) {
		let nibName = UINib(nibName: "FlightCell", bundle: nil)
		table.register(nibName, forCellReuseIdentifier: "flightCell")
	}

}

extension BaseFlightViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	// Here: Implement get data to update tableViews:
	//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	//		return flights.count
	//	}
	//
	//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	//		let flight = flights[indexPath.row]
	//		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
	//		cell.textLabel?.text = flight.value(forKey: "airline") as! String
	//		print("cell ready")
	//		return cell
	//	}
}
