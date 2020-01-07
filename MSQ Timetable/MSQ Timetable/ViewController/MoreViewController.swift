//
//  MoreViewController.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/7/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit
import SafariServices

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	@IBAction func externalLinkOpened(_ sender: UIButton) {
		showSafariVC(url: "https://airport.by/en")
	}

	func showSafariVC(url: String) {
		
		guard let url = URL(string: url) else { return }
		
		let safariVC = SFSafariViewController(url: url)
		present(safariVC, animated: true)
	}
	
	
}
