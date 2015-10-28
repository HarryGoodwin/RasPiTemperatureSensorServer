//
//  ViewController.swift
//  RasPiTempSensorClient
//
//  Created by Harry Goodwin on 28/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TemperatureWebServiceDelegate
{
	@IBOutlet weak var currentTempLabel: UILabel!
	@IBOutlet weak var lastUpdateLabel: UILabel!
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(animated)
		
		let webService = TemperatureWebService()
		webService.delegate = self
		webService.startConnection()
	}
	
	func temperatureReceived(temperature: String, date: String)
	{
		currentTempLabel.text = "\(temperature) °C"
		lastUpdateLabel.text = "\(date)"
	}
}

