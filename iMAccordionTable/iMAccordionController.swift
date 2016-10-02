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
		boolArray = [String](repeating: "0", count: sectionArray.count)
		
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
	override func numberOfSections(in tableView: UITableView) -> Int{
		return sectionArray.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		let boolForSec = boolArray[section] as String
		if (boolForSec.toInt() != 0) {
			let arr = dataDic[sectionArray[section]]
			return arr!.count
		}else {
			return 0
		}
	}
	

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
		
		let boolForSec = boolArray[(indexPath as NSIndexPath).section] as String
		if (boolForSec.toInt() != 0) {
			var arr : [String] = dataDic[sectionArray[(indexPath as NSIndexPath).section]]!
			cell.textLabel?.text = arr[(indexPath as NSIndexPath).row] as String
			cell.textLabel?.textColor = UIColor.white
			cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
			cell.textLabel?.backgroundColor = UIColor.clear
		}else {
			
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 50
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
		headerView.backgroundColor = UIColor.blue
		headerView.tag = section
		
		let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
		headerString.textColor = UIColor.white
		headerString.font = UIFont.systemFont(ofSize: 25)
		headerString.text = sectionArray[section] as String
		headerView .addSubview(headerString)
		
		let headerTapped = UITapGestureRecognizer (target: self, action:#selector(iMAccordionController.sectionHeaderTapped(_:)))
		headerView .addGestureRecognizer(headerTapped)
		
		return headerView
	}
	
	// MARK: UITableView Delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		changeFlagForSection((indexPath as NSIndexPath).section)
		tableView.reloadSections(IndexSet(integer: (indexPath as NSIndexPath).section), with: UITableViewRowAnimation.fade)
	}
	
	// Handle Tap on section
	func sectionHeaderTapped(_ tapped: UITapGestureRecognizer){
		
		guard let section = tapped.view?.tag else{
			print("Cannot found tapped view tag")
			return
		}
		
		changeFlagForSection(section)
		
		// Relaod tableview with animation
		tableView.reloadSections(IndexSet(integer: section), with: UITableViewRowAnimation.fade)
	}
	
	// Handle collaspable flag
	func changeFlagForSection(_ section: Int){
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
