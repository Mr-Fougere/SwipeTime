//
//  GifImage.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 20/06/2023.
//
import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!

        DispatchQueue.main.async {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }

        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No need to explicitly reload the web view as it will automatically display the updated content.
    }
}
