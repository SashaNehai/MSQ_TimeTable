//
//  FlightDetailsViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/16/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController {
	
	var flight = Flight2()
	
	@IBOutlet weak var navigationView: UINavigationItem!
	@IBOutlet weak var airlineLabel: UILabel!
	@IBOutlet weak var destinationLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var gateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	@IBOutlet weak var airlineLogo: UIImageView!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.backBarButtonItem?.tintColor = .white
		
		navigationView.title = flight.flightId
		airlineLabel.text = flight.airline
		statusLabel.text = flight.status.map { $0.rawValue }
		destinationLabel.text = flight.destination
		
		gateLabel.text = flight.gate
		timeLabel.text = flight.time
		
		
		airlineLogo.image = setAirlineLogo(airline: flight.airline!)
		let fs = FlightStatus(rawValue: flight.status!.rawValue)
		statusLabel.textColor = fs?.color
		//		favorite flight feature will be implement later
		favoriteButton.isEnabled = false
		//		setFavoriteButtonDesign()
	}
	
	@IBAction func favoriteButtonPressed(_ sender: Any) {
		if flight.favorite == true {
			flight.favorite = false
		} else {
			flight.favorite = true
		}
		setFavoriteButtonDesign()
	}
	
	
	func setFavoriteButtonDesign() {
		favoriteButton.tintColor = .white
		if flight.favorite {
			favoriteButton.image = UIImage(systemName: "star.fill")
		} else {
			favoriteButton.image = UIImage(systemName: "star")
		}
	}
	
	func setAirlineLogo(airline: String) -> UIImage {
		switch airline {
		case "BELAVIA":
			return UIImage(named: "Belavia")!
		case "AEROFLOT":
			return UIImage(named: "Aeroflot")!
		case "LUFTHANSA GERMAN AIRLINES":
			return UIImage(named: "Lufthansa")!
		case "UTAIR":
			return UIImage(named: "Utair")!
		case "TURKISH AIRLINES":
			return UIImage(named: "Turkish-Airlines")!
		case "LOT POLISH AIRLINES":
			return UIImage(named: "LOT")!
		case "UZBEKISTAN AIRWAYS":
			return UIImage(named: "uzbekistan-airways")!
		case "AIR CHINA INTERNATIONAL C":
			return UIImage(named: "Air_China")!
		case "AUSTRIAN AIRLINES":
			return UIImage(named: "Austrian_Airlines")!
		case "AIR BALTIC":
			return UIImage(named: "airbaltic")!
		case "MOTOR SICH":
			return UIImage(named: "Motor_Sich")!
		default:
			return UIImage(named: "default")!
		}
	}
	
	
}
