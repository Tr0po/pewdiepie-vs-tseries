//
//  ViewController.swift
//  PewDiePie vs T-Series
//
//  Created by Admin on 12.12.18.
//  Copyright © 2018 glueckkanja.com. All rights reserved.
//

import UIKit

extension String
{
    func counter() -> String
    {
        if let regex = try? NSRegularExpression(pattern: "[0-9,]+ subscribers", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length:string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: " subscribers", with: "").lowercased()} ?? ""
        }
        
        return self
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var pewdiesubs: UILabel!
    @IBOutlet weak var tseriessubs: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pewsubs()
        tsubs()
        
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(pewsubs), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(tsubs), userInfo: nil, repeats: true)
        
    }
    
    @objc func pewsubs() {
        let myURLString = "https://www.youtube.com/user/PewDiePie"
        guard let myURL = URL(string: myURLString) else {
            pewdiesubs.text = "Error: \(myURLString) doesn't seem to be a valid URL"
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            pewdiesubs.text = "\(myHTMLString.counter())"
        } catch let error {
            pewdiesubs.text = "---"
        }
        
    }
    
    
    @objc func tsubs() {
        let myURLString = "https://www.youtube.com/user/tseries"
        guard let myURL = URL(string: myURLString) else {
            tseriessubs.text = "Error: \(myURLString) doesn't seem to be a valid URL"
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            tseriessubs.text = "\(myHTMLString.counter())"
        } catch let error {
            tseriessubs.text = "---"
        }
        
    }
}
