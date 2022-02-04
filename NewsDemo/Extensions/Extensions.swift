//
//  Extensios.swift
//  NewsApp
//
//  Created by Mostafa on 2/4/22.
//

import Foundation
import UIKit
import Kingfisher
extension String{
    func convertToUrl()->URL?{
        URL(string: self
        )
    }
}
extension UIView{
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    

}
extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


}
