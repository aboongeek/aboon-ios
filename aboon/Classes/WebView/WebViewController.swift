//
//  WebViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/14.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    let webView = WebView()
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: url)
        webView.webView.load(request)
        
        webView.refreshButton.action = #selector(refreshTapped)
        webView.backButton.action = #selector(backTapped)
        webView.forwardButton.action = #selector(forwardTapped)
        webView.doneButton.action = #selector(doneTapped)
    }
    
    @objc func refreshTapped() {
        webView.webView.reload()
    }
    
    @objc func backTapped() {
        webView.webView.goBack()
    }
    
    @objc func forwardTapped() {
        webView.webView.goForward()
    }
    
    @objc func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
