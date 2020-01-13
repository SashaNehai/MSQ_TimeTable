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
		depaturesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "depatureCell")
		
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
		 network.getArrivalInfo(infoUrl: "https://airport.by/en/timetable/online-departure") { [weak self] flightInfo in
			 self?.depatureFlights = flightInfo
			 self?.depaturesTableView.reloadData()
		}
	}
}

extension DepaturesViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return depatureFlights.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = depaturesTableView.dequeueReusableCell(withIdentifier: "depatureCell", for: indexPath)
		cell.textLabel?.text = depatureFlights[indexPath.row]?[0]
		return cell
	}
}
