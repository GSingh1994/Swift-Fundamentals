//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Gagan on 2023-02-07.
//

import UIKit
import WebKit //integrate web content to app

class ViewController: UIViewController, WKNavigationDelegate { //method for accepting/rejecting nav changes
    
    var webView: WKWebView! //display interactive web-content
    var progressView: UIProgressView!
    
    var websites = ["apple.com", "gagansingh.dev", "neal.fun/paper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, back, forward, refresh]
        
        navigationController?.isToolbarHidden = false
        
        webView = WKWebView()
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            // constrain web view to all 4 sides of the Safe Area
            webView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
            webView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0.0),
            webView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0.0),
            webView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0.0),
            
        ])
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { //start when webview finish loading page
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            let ac = UIAlertController(title: "Unsafe website", message: "You shall not pass", preferredStyle: .alert)
            present(ac, animated: true)
        }
        decisionHandler(.cancel)
    }
}
