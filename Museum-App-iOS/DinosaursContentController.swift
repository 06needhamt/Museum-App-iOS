//
//  DinosaursContentController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 10/09/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class DinosaursContentController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    var Trails:[String] = []
    
    @IBOutlet weak var AvailableTrailPicker: UIPickerView!
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AvailableTrailPicker.delegate = self as UIPickerViewDelegate
        AvailableTrailPicker.dataSource = self as UIPickerViewDataSource // set the delegate and data sources
        let db:DatabaseLoader = DatabaseLoader() // initialise the database
        db.openDatabase() // open the database
        let Results:FMResultSet = db.queryDatabase("SELECT tra_name FROM trail") // query the database
        while(Results.next()){
            Trails.append(Results.stringForColumn("tra_name")) // add all of the trails to the data array
        }
        if(Trails.count == 0){
            NSLog("No Trails Found")
            Trails.append("No Trails Available")
        }
        NSLog("%i Trails Found" , Trails.count)
        db.closeDatabase() // close the database
        NSLog("Dinosaurs Content Controller Loaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1 // number of columns in the spinner
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Trails.count // get the number of items in the spinner
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        NSLog("You Selected %@", Trails[row])
        return Trails[row] // get the selected item from the spinner
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: Trails[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return attributedString // change text colour to white
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myLabel.text = Trails[row]
    }

}
