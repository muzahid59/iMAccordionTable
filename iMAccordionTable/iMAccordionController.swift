//
//  iMAccordionController.swift
//  iMAccordionTable
//
//  Created by Muzahidul Islam on 3/23/16.
//  Copyright © 2016 iMuzahid. All rights reserved.
//

import UIKit




class iMAccordionController: UITableViewController {
    var allSections: [SectionData] = []
    
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "iMAccordion Table"
		
        let sectionA = SectionData(title: "A", items: ["BANGLADESH","INDIA","PAKISTHAN","SOUTH AFRICA"])
        let sectionB = SectionData(title: "B", items: ["AUSTRALIA","ENGLAND","SRILANKA","WEST INDIES"])
        let sectionC = SectionData(title: "C", items: ["WOMAN","HOLAND","IRELAND","POLAND"])
        
        allSections = [sectionA, sectionB, sectionC]
	}
	
	//MARK: UITableView DataSource
	override func numberOfSections(in tableView: UITableView) -> Int{
        return allSections.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let sectionData = allSections[section]
        if sectionData.isExpand {
            return sectionData.items.count
        } else {
            return 0
        }
	}
	

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        let sectionData = allSections[indexPath.section]
        
        if sectionData.isExpand {
            let text = sectionData.items[indexPath.row]
			cell.textLabel?.text = text
			cell.textLabel?.textColor = UIColor.white
			cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
			cell.textLabel?.backgroundColor = UIColor.clear
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
        let title = allSections[section].title
		headerString.text = title
		headerView.addSubview(headerString)
		
		let headerTapped = UITapGestureRecognizer (target: self, action:#selector(iMAccordionController.sectionHeaderTapped(_:)))
		headerView .addGestureRecognizer(headerTapped)
		
		return headerView
	}
	
	// Handle Tap on section
    @objc func sectionHeaderTapped(_ tapped: UITapGestureRecognizer){
		guard let section = tapped.view?.tag else {
            print("Cannot found tapped view tag")
            return
		}
		
		if allSections.indices.contains(section) {
            let currentState = allSections[section].isExpand
            allSections[section].isExpand = !currentState
        }
		
		// Relaod tableview with animation
        tableView.reloadSections(IndexSet(integer: section), with: UITableView.RowAnimation.fade)
	}
	
	// Handle collaspable flag
	func changeFlagForSection(_ section: Int) {

	}

	
}

// String to int conversion
extension String{

	func toInt()->Int{
		return Int(self)!
	}
	
}
