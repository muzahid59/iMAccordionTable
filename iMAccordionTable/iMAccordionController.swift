//
//  iMAccordionController.swift
//  iMAccordionTable
//
//  Created by Muzahidul Islam on 3/23/16.
//  Copyright © 2016 iMuzahid. All rights reserved.
//

import UIKit

class iMAccordionController: UITableViewController {

	var sectionArray = [String]() // Number of sections
	var boolArray : [String]!
	var dataDic = [String : [String]]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "iMAccordion Table"
		
		
		sectionArray = ["A","B","C"]
		
		// Intially set all sections are not being collasp
		// String "0" means disable collasp and "1" means enable collasp
		boolArray = [String](count: sectionArray.count, repeatedValue: "0")
		
		let groupA = ["BANGLADESH","INDIA","PAKISTHAN","SOUTH AFRICA"]
		let groupB = ["AUSTRALIA","ENGLAND","SRILANKA","WEST INDIES"]
		let groupC = ["WOMAN","HOLAND","IRELAND","POLAND"]
		
		// Number of rows under section
		dataDic["A"] = groupA
		dataDic["B"] = groupB
		dataDic["C"] = groupC
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//MARK: UITableView DataSource
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
		return sectionArray.count
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		let boolForSec = boolArray[section] as String
		if (boolForSec.toInt() != 0) {
			let arr = dataDic[sectionArray[section]]
			return arr!.count
		}else {
			return 0
		}
	}
	

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
		
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
		
		let boolForSec = boolArray[indexPath.section] as String
		if (boolForSec.toInt() != 0) {
			var arr : [String] = dataDic[sectionArray[indexPath.section]]!
			cell.textLabel?.text = arr[indexPath.row] as String
			cell.textLabel?.textColor = UIColor.whiteColor()
			cell.textLabel?.font = UIFont.systemFontOfSize(20)
			cell.textLabel?.backgroundColor = UIColor.clearColor()
		}else {
			
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 50
	}
	
	override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 1
	}
	
	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
		headerView.backgroundColor = UIColor.blueColor()
		headerView.tag = section
		
		let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
		headerString.textColor = UIColor.whiteColor()
		headerString.font = UIFont.systemFontOfSize(25)
		headerString.text = sectionArray[section] as String
		headerView .addSubview(headerString)
		
		let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
		headerView .addGestureRecognizer(headerTapped)
		
		return headerView
	}
	
	// MARK: UITableView Delegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		changeFlagForSection(indexPath.section)
		tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
	}
	
	// Handle Tap on section
	func sectionHeaderTapped(tapped: UITapGestureRecognizer){
		
		guard let section = tapped.view?.tag else{
			print("Cannot found tapped view tag")
			return
		}
		
		changeFlagForSection(section)
		
		// Relaod tableview with animation
		tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Fade)
	}
	
	// Handle collaspable flag
	func changeFlagForSection(section: Int){
		let boolForSec = boolArray[section] as String
		if (boolForSec.toInt() != 0) {
			// if section is already collasp then disable collasp flag
			boolArray[section] = "0"
		}else {
			// if section is not collasp then enable collasp flag
			boolArray[section] = "1"
		}

	}

	
}

// String to int conversion
extension String{

	func toInt()->Int{
		return Int(self)!
	}
	
}
