//
//  AuthView.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import SwiftUI


public struct GithubAuthView: ViewModifier {
    
    @StateObject
    var viewModel: ViewModel
    
    @Binding
    var isPresented: Bool
    
    public init(isPresented: Binding<Bool>, github: Github, _ completion: @escaping Github.Completion) {
        _isPresented = isPresented
        _viewModel = .init(wrappedValue: .init(github: github, completion: completion))
    }
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented,
                   onDismiss: {
                viewModel.didDismissSheet()
            }) {
                Github.AuthWebView(store: viewModel.webViewStore, onChangeOfURL: viewModel.urlDidChange)
                    .interactiveDismissDisabled(!viewModel.canDismissSheet)
            }
            .onChange(of: viewModel.showWebview) { showWebView in
                isPresented = showWebView
            }
            .onChange(of: isPresented) { isPresented in
                if isPresented { viewModel.beginAuth() }
            }
    }
}

public extension View {
    @ViewBuilder
    func githubAuthSheet(isPresented: Binding<Bool>, _ completion: @escaping Github.Completion) -> some View {
        if let github = Github.shared {
            self.modifier(GithubAuthView(isPresented: isPresented, github: github, completion))
        } else {
            fatalError("Missing call to Github.configure(_:)\n please make sure you set up the library correctly.")
        }
    }
}


extension Github {
    struct AuthWebView: View {
        
        @StateObject
        var store: WebViewStore
        
        let onChangeOfURL: (URL) -> Void
        
        var body: some View {
            WebView(webView: store.webView)
                .onChange(of: store.url) { newValue in
                    guard let newValue else { return }
                    onChangeOfURL(newValue)
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    class Model: ObservableObject {
        @Published
        var showSheet: Bool = false
    }
    
    @StateObject
    static var model: Model = .init()
    
    static var previews: some View {
        Button {
            model.showSheet.toggle()
        } label: {
            Text("Login with Github")
                .padding()
        }
        .githubAuthSheet(isPresented: $model.showSheet) { config in
            print(config)
        }
    }
}
