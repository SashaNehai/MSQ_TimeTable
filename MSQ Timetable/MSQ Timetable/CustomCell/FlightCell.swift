//
//  DepatureViewCell.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/13/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {
	
	@IBOutlet weak var destinationLabel: UILabel!
	@IBOutlet weak var flightIdLabel: UILabel!
	@IBOutlet weak var airlineLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var gateLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	
	func cellUpdate( destination: String, flightId: String, airline: String, time: String, gate: String, status: String) {
		destinationLabel.text = destination
		flightIdLabel.text = flightId
		airlineLabel.text = airline
		timeLabel.text = time
		gateLabel.text = gate
		statusLabel.text = status
		
		flightIdLabel.textColor = UIColor.gray
		airlineLabel.textColor = UIColor.gray
		gateLabel.textColor = UIColor.gray
		
		let fs = FlightStatus(rawValue: status)
		statusLabel.textColor = fs?.color
	}
	
}
