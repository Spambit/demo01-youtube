//
//  ViewController.swift
//  Demo01
//
//  Created by Cognition on 26/12/17.
//  Copyright © 2017 Cognition. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyProgressBarDelegate{

    private var timer:Timer!
    private var progressView:MyProgressBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedOuterStackView(_ sender: UITapGestureRecognizer) {
        self.showProgressBar()
    }
    private func showProgressBar()
    {
        let progressView = Bundle.main.loadNibNamed("MyProgressBar", owner: nil, options: nil)?.first as! UIView
        self.navigationController?.view.addSubview(progressView)
        self.navigationController?.view.bringSubview(toFront: progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        progressView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.3) {
            progressView.alpha = 1.0
        }
        
        self.progressView = progressView as! MyProgressBar
        //self.progressView.delegate = self;
        
        self.testProgressBar()
    }
    
    private func testProgressBar() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.progressView.progress += 1
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.invalidateTimer()
    }
    
    func progressBar(didDismiss progressBar: MyProgressBar) {
        self.invalidateTimer()
        self.progressView = nil
    }
    
    private func invalidateTimer (){
        self.timer?.invalidate()
        self.timer = nil
    }
}

