//
//  FlightDetailsViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/16/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController {

    var flight = Flight()
		
		@IBOutlet weak var navigationView: UINavigationItem!
		@IBOutlet weak var airlineLabel: UILabel!
		@IBOutlet weak var destinationLabel: UILabel!
		@IBOutlet weak var statusLabel: UILabel!
		@IBOutlet weak var favoriteButton: UIBarButtonItem!
	@IBOutlet weak var airlineLogo: UIImageView!
	
		override func viewDidLoad() {
			super.viewDidLoad()
			navigationItem.backBarButtonItem?.tintColor = .white
			
			navigationView.title = flight.flightId
			airlineLabel.text = flight.airline
			statusLabel.text = flight.status
			destinationLabel.text = flight.destination
			
			favoriteButtonDesign()
			
			switch flight.status {
			case "AIRBORNE":
				statusLabel.textColor = UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
			case "ARRIVED":
				statusLabel.textColor = UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
			case "LANDED":
				statusLabel.textColor = UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
			case "BOARDING":
				statusLabel.textColor = UIColor(red: 17/255.0, green: 10/255.0, blue: 139/255.0, alpha: 1.0)
			case "EN ROUTE":
				statusLabel.textColor = UIColor(red: 17/255.0, green: 10/255.0, blue: 139/255.0, alpha: 1.0)
			case "CHECK-IN":
				statusLabel.textColor = UIColor(red: 255/255.0, green: 239/255.0, blue: 0/255.0, alpha: 1.0)
			case "DELAYED":
				statusLabel.textColor = UIColor(red: 185/255.0, green: 28/255.0, blue: 20/255.0, alpha: 1.0)
			case "CANCELLED":
				statusLabel.textColor = UIColor(red: 185/255.0, green: 28/255.0, blue: 20/255.0, alpha: 1.0)
			default:
				statusLabel.textColor = UIColor.gray
			}
		}
		
		@IBAction func favoriteButtonPressed(_ sender: Any) {
			if flight.favorite == true {
				flight.favorite = false
			} else {
				flight.favorite = true
			}
			favoriteButtonDesign()
		}
		
		
		func favoriteButtonDesign() {
			
			favoriteButton.tintColor = .white
			if flight.favorite {
				favoriteButton.image = UIImage(systemName: "star.fill")
			} else {
				favoriteButton.image = UIImage(systemName: "star")
			}
		}
		
		
	}
