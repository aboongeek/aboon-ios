//
//  WebView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/14.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIView {

    lazy var webView = WKWebView()
    
    @IBOutlet weak var webToolBar: UIToolbar!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        guard let view = UINib(nibName: "WebView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        view.frame = self.frame
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(webView, at: 0)
        if #available(iOS 11.0, *) {
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        webView.bottomAnchor.constraint(equalTo: webToolBar.topAnchor).isActive = true

    }
}
