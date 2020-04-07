//
//  FlightDetailsViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/16/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit
import Kingfisher

class FlightDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationView: UINavigationItem!
    @IBOutlet weak var airlineLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var flight: FlightDetail?
    var properties = [String]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.tintColor = .white
        
        setNavigationBarDesign()
        setAirlineLogo()
        gatherTable()
    }
    
    // MARK: - Methods
    private func setNavigationBarDesign() {
        navigationView.title = flight?.flight
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = Constants.Color.mainRed
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    private func gatherTable() {
        appendToTable(title: "City", value: flight?.airport.title)
        appendToTable(title: "Airline", value: flight?.airline.title)
        appendToTable(title: "Flight Number", value: flight?.flight)
        appendToTable(title: "Status", value: flight?.status.title)
        appendToTable(title: "Gate", value: flight?.gate)
        appendToTable(title: "Schedule time", value: flight?.plan)
        appendToTable(title: "Actual time", value: flight?.fact)
        appendToTable(title: "Aircraft", value: flight?.aircraft.title)
        
        tableView.reloadData()
    }
    
    private func appendToTable(title: String, value: String?) {
        if let value = value {
            properties.append("\(title): \(value)")
        }
    }
    
    private func setAirlineLogo() {
        guard let path = flight?.airline.logo.path,
            let url = URL(string: Constants.logoBaseUrl+path) else { return }
        airlineLogo.kf.setImage(with: url, placeholder: UIImage(named: "default"), options: nil, progressBlock: nil)
    }
    
    
}

extension FlightDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = properties[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .lightGray
        return cell
    }
    
}
