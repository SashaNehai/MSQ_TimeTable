//
//  FlightsViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/7/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FlightsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var segmentControlView: UIView!
    
    // MARK: - Variables
    let bag = DisposeBag()
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel = FlightsViewModelImpl()
    var flights = [FlightDetail]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        
        setTableSettings(table: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBarDesign()
        setRefreshControlDesign()
//        setSearchBarSettings()
        setSementControl()
    }
    
    // MARK: - Methods
    /*
    func setSearchBarSettings() {
        searchBar.searchBarStyle = .default
        searchBar.barTintColor = Constants.Color.mainRed
        searchBar.isTranslucent = false
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.tintColor = Constants.Color.mainRed
            searchBar.searchTextField.textColor = .white
        }
        
        guard let textField = searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textField.leftView as? UIImageView else { return }
        textField.backgroundColor = .white
        textField.textColor = .gray
        textField.tintColor = .gray
        
        let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.white]
        textField.attributedPlaceholder = NSAttributedString(string: "Flight Number", attributes: attributeDict)
        glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        glassIconView.tintColor = .gray
    }
    */
    func setSementControl() {
        segmentControl.backgroundColor = .white
       
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.mainRed]
        segmentControl.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        if #available(iOS 13.0, *) {
            segmentControl.selectedSegmentTintColor = Constants.Color.mainRed
        } else {
            segmentControl.tintColor = Constants.Color.mainRed
        }
    }
    
    func setNavigationBarDesign() {
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
    
    func setTableSettings(table: UITableView) {
        let nibName = UINib(nibName: "FlightCell", bundle: nil)
        table.register(nibName, forCellReuseIdentifier: "flightCell")
        tableView.tableFooterView = UIView()
    }
    
    func setRefreshControlDesign() {
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshFlightData(_:)), for: .valueChanged)
        refreshControl.tintColor = Constants.Color.mainRed
    }
    
    @objc private func refreshFlightData(_ sender: Any) {
        refreshControl.endRefreshing()
    }
    
}

// MARK: - Binding
extension FlightsViewController {
    func binding() {
        viewModel.flightsObservable.debug().subscribe(onNext: { (flights) in
            self.flights = flights
            self.tableView.reloadData()
        }).disposed(by: bag)

        segmentControl.rx.selectedSegmentIndex.debug()
            .bind(to: viewModel.flightTypeObserver)
            .disposed(by: bag)
        
    }
}

// MARK: - UITableViewDelegate
extension FlightsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "FlightDetails", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FlightDetailsViewController") as! FlightDetailsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)

        nextViewController.flight = flights[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension FlightsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FlightCell = tableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as! FlightCell
        cell.setCell(model: flights[indexPath.row])
        return cell
    }
    
}
