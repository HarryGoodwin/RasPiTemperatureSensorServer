//
//  TemperatureWebService.swift
//  RasPiTempSensorClient
//
//  Created by Harry Goodwin on 28/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation
import UIKit

protocol TemperatureWebServiceDelegate
	
{
	func temperatureReceived(temperature: String, date: String)
}

class TemperatureWebService: NSObject, NSURLConnectionDelegate
{
	var delegate: TemperatureWebServiceDelegate?
	var data = NSMutableData()
	var jsonResult: NSArray = []
 
	func startConnection()
	{
		let urlPath: String = "http://192.168.0.11/temperaturejson.php"
		let url: NSURL = NSURL(string: urlPath)!
		let request: NSURLRequest = NSURLRequest(URL: url)
		let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
	}
	
	func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
	{
		self.data.appendData(data)
	}
	
	func connectionDidFinishLoading(connection: NSURLConnection!)
	{
		do
		{
			try jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
		}
		catch
		{
			print("json error: \(error)")
		}
		
		getLatestTempReading()
	}
	
	func getLatestTempReading()
	{
		let dictionary: NSDictionary = jsonResult.lastObject as! NSDictionary
		let tempValue = dictionary.objectForKey("Temp") as! String
		let dateValue = dictionary.objectForKey("Date") as! String
		
		
		if (delegate != nil)
		{
			delegate?.temperatureReceived(tempValue, date: dateValue)
		}
	}
}