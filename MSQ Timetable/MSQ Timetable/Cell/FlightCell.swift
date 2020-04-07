//
//  DepatureViewCell.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/13/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {
	
    // MARK: - Outlets
	@IBOutlet weak var destinationLabel: UILabel!
	@IBOutlet weak var flightIdLabel: UILabel!
	@IBOutlet weak var airlineLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	
    // MARK: - Methods
    func setCell(model: FlightDetail) {
        destinationLabel.text = model.airport.title
        flightIdLabel.text = model.flight
        airlineLabel.text = model.airline.title
        timeLabel.text = model.plan
        statusLabel.text = model.status.title
        
        
        let fs = FlightStatus(rawValue: model.status.title ?? "")
        statusLabel.textColor = fs?.color
    }
    
}
