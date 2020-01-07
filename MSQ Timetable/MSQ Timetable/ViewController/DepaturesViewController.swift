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
	
	override func viewDidLoad() {
        super.viewDidLoad()
		depaturesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "depatureCell")
	}
}

extension DepaturesViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = depaturesTableView.dequeueReusableCell(withIdentifier: "depatureCell", for: indexPath)
		cell.textLabel?.text = "Depatures"
		return cell
	}
}
