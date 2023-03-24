//
//  Authview+ViewModel.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation
import WebKit
import SwiftUI

extension GithubAuthView {
    class ViewModel: ObservableObject {
        
        private let github: Github
        private let completion: Github.Completion
        let webView: WKWebView
        let webViewStore: WebViewStore
        
        @Published
        var showWebview: Bool = true
        
        @Published
        var isBusy: Bool = false
        
        @Published
        var canDismissSheet: Bool = true
        
        private var didSetInitialURL: Bool = false
        
        private let requestBuilder: Github.Configuration.RequestBuilder
        
        init(github: Github, completion: @escaping Github.Completion) {
            self.github = github
            self.completion = completion
            let webView = WKWebView()
            self.webView = webView
            self.webViewStore = .init(webView: webView)
            self.requestBuilder =  github.requestBuilder
        }
        
        func beginAuth() {
            webView.load(requestBuilder.webviewRequest)
        }
        
        func didDismissSheet() {
            didSetInitialURL = false
        }
        
        func urlDidChange(_ url: URL) {
            if didSetInitialURL {
                canDismissSheet = false
            } else {
                didSetInitialURL = true
            }
            guard requestBuilder.responds(to: url) else { return }
            
            defer {
                showWebview = false
            }
            
            do {
                let code = try requestBuilder.getCode(from: url)
                getAuthToken(from: code)
            } catch {
                completion(.failure(error))
            }
        }
        
        private func getAuthToken(from code: String) {
            isBusy = true
            Task {
                do {
                    let token = try await requestBuilder.getOAuthToken(fromAccessCode: code)
                    github.persistenceManager.persistConfiguration(token)
                    completion(.success(token))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

public extension Github {
    enum AuthError: Error {
        /// The initial authentication has not returned any code.
        case noAuthCode
        
        /// The response's `state` parameter did not match the request's `state` parameter.
        case crossSiteForgeryDetected
    }
}
