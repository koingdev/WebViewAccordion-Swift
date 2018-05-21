//
//  AccordionCell.swift
//  TestWebViewAccordion
//
//  Created by KoingDev on 5/19/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

class AccordionCell: UITableViewCell, UIWebViewDelegate {
    
    var cellExists = false
    
    @IBOutlet var toggleAccordion: UIButton!
    
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.isHidden = true
            webView.alpha = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.delegate = self
        contentView.backgroundColor = UIColor.init(red: 50/255, green: 54/255, blue: 64/255, alpha: 1)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let contentHeight = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight") {
            let height = (contentHeight as NSString).floatValue
            ViewController.webViewHeight[webView.tag] = CGFloat(height) + 20.0
        }
    }
    
    func animate(duration: Double, completion: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: { [unowned self] in
                self.webView.isHidden = !self.webView.isHidden
                if self.webView.alpha == 1 {
                    self.webView.alpha = 0.5
                } else {
                    self.webView.alpha = 1
                }
            })
        }, completion: { _ in
            completion()
        })
    }
    
}
