//
//  DetailsArticleViewController.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import UIKit
import WebKit

class DetailsArticleViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterDetailsArticleProtocol?
    
    var webView: WKWebView!
}

extension DetailsArticleViewController: PresenterToViewDetailsArticleProtocol{
    // TODO: Implement View Output Methods
    func onSendArticleSuccess(article: Article) {
        if let source = article.source {
            print(source)
        }
        loadWebsite(urlstring: article.url ?? "")
    }
}

extension DetailsArticleViewController: WKNavigationDelegate {
    func setupUI() {
        self.view.backgroundColor = .white
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
    }
    
    func loadWebsite(urlstring: String) {
        if let url = URL(string: urlstring) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let activityIndicator = view.subviews.first(where: { $0 is UIActivityIndicatorView }) {
            activityIndicator.removeFromSuperview()
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if let activityIndicator = view.subviews.first(where: { $0 is UIActivityIndicatorView }) {
            activityIndicator.removeFromSuperview()
        }
    }
}
