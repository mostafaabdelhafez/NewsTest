//
//  DetailsFooter.swift
//  NewsApp
//
//  Created by Mostafa on 2/4/22.
//

import UIKit

import UIKit

class DetailsFooter: UIView {
    var showAlert:(()->())!
    @IBOutlet weak var rateTextField:UITextField!
    @IBAction func rateButtonDidTapped(){

        let rateRange = 1...5
        guard rateTextField.text != nil
        else{return}
        guard let numericRating = Int(rateTextField.text ?? "")  else{return}
        if rateRange.contains(numericRating){
            print("valid rating")
            showAlert()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
