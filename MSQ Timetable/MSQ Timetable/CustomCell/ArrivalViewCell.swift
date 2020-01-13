//
//  ArrivalViewCell.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/13/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class ArrivalViewCell: UITableViewCell {
	
	@IBOutlet weak var destinationLabel: UILabel!
	@IBOutlet weak var flightIdLabel: UILabel!
	@IBOutlet weak var airlineLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	func cellUpdate( destination: String, flightId: String, airline: String, time: String, status: String) {
		destinationLabel.text = destination
		flightIdLabel.text = flightId
		airlineLabel.text = airline
		timeLabel.text = time
		statusLabel.text = status
		
		flightIdLabel.textColor = UIColor.gray
		airlineLabel.textColor = UIColor.gray
		
		switch status {
		case "ARRIVED":
			statusLabel.textColor = UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
		case "LANDED":
			statusLabel.textColor = UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
		case "EN ROUTE":
			statusLabel.textColor = UIColor(red: 17/255.0, green: 10/255.0, blue: 139/255.0, alpha: 1.0)
		case "DELAYED":
			statusLabel.textColor = UIColor(red: 185/255.0, green: 28/255.0, blue: 20/255.0, alpha: 1.0)
		default:
			statusLabel.textColor = UIColor.gray
		}
	}
	
}
