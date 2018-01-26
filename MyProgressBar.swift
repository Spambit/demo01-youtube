//
//  MyProgressBar.swift
//  Demo01
//
//  Created by Cognition on 29/12/17.
//  Copyright © 2017 Cognition. All rights reserved.
//

import UIKit
public protocol MyProgressBarDelegate : class{
    func progressBar(didDismiss progressBar:MyProgressBar)
}

public class MyProgressBar: UIView {
    @IBOutlet weak var parcentageLabel: UILabel!
    @IBOutlet weak var indicatorView: AwesomeProgressView!
    @IBOutlet weak var cancelButton: UIButton!
    private var dismissed:Bool = false
    weak public var delegate:MyProgressBarDelegate!
    override public func layoutSubviews() {
        self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.width/2
        self.cancelButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.cancelButton.layer.borderColor = UIColor.white.cgColor
        self.cancelButton.layer.borderWidth = 0.8
        self.cancelButton.layer.masksToBounds = true
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss()
    }
    
    
    private func showPercentage(forProgress progress:Double)
    {
        let title = String.localizedStringWithFormat("%0.f %%", progress)
        let attributedTitle = NSMutableAttributedString(string: title)
        let startRange = NSMakeRange(0,title.count-2)
        let endRange = NSMakeRange(title.count-1,1)
        attributedTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18), range: startRange)
        attributedTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: endRange)
        self.parcentageLabel!.attributedText = attributedTitle
    }
    
    public var progress:Double = 0.0{
        willSet(value){
            if value < 0 || value > 100 {
                self.dismiss()
            }
            DispatchQueue.main.async {
                self.showPercentage(forProgress: value)
                self.indicatorView.progress = value
                //self.indicatorView.setNeedsDisplay()
            }
        }
    }
    
    public func dismiss(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0.0
            }) { (finished) in
                self.progress = 0
                self.dismissed = true
                if let delegate = self.delegate {
                    delegate.progressBar(didDismiss: self)
                }
                self.removeFromSuperview()
            }
        }
    }
}
