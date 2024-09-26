//
//  WebView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var urlToLoad: String
    
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}
