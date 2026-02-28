//
//  ContentView.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//

import SwiftUI
import Down
import WebKit

// MARK: - Main Content View with Tab Bar

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 第一个页面：Markdown编辑器
            MarkdownEditorView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("编辑器")
                }
                .tag(0)
            
            // 第二个页面：聊天页面
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("聊天")
                }
                .tag(1)
            
            // 第三个页面：设置页面
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
                .tag(2)
            
            // 第四个页面：关于页面
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("关于")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}

// MARK: - Markdown Editor View

struct MarkdownEditorView: View {
    var body: some View {
        NavigationView {
            MarkdownViewControllerWrapper()
                .navigationTitle("Markdown编辑器")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Feature Row Component

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

// MARK: - UIViewControllerRepresentable Wrapper (保持原有的Markdown编辑器)

struct MarkdownViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MarkdownRenderViewController
    
    func makeUIViewController(context: Context) -> MarkdownRenderViewController {
        return MarkdownRenderViewController()
    }
    
    func updateUIViewController(_ uiViewController: MarkdownRenderViewController, context: Context) {
        // 更新UI的逻辑（如果需要的话）
    }
}

// MARK: - 保持原有的MarkdownRenderViewController类

class MarkdownRenderViewController: UIViewController {
    // MARK: - UI Components

    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        config.userContentController.add(self, name: "mermaidReady")
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .systemBackground
        return webView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.delegate = self
        return textView
    }()
    
    private lazy var renderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("渲染内容", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(renderContent), for: .touchUpInside)
        return button
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["编辑", "预览"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return control
    }()
    
    private var currentContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSampleContent()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(segmentedControl)
        view.addSubview(textView)
        view.addSubview(webView)
        view.addSubview(renderButton)
        
        setupConstraints()
        webView.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            textView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: renderButton.topAnchor, constant: -16),
            
            webView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            renderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            renderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            renderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            renderButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSampleContent() {
        let sampleContent = """
        # Talk2Me - 智能Markdown编辑器

        ## 欢迎使用Talk2Me！

        这是一个功能强大的Markdown编辑器，集成了AI聊天功能。

        ### 主要特性
        - ✅ **实时预览**：支持Markdown语法实时渲染
        - ✅ **AI聊天**：内置智能对话助手
        - ✅ **多主题**：支持深色和浅色主题切换
        - ✅ **代码高亮**：支持多种编程语言语法高亮

        ### 示例代码
        ```swift
        func greetUser(name: String) {
            print("Hello, \\(name)! Welcome to Talk2Me!")
        }
        
        greetUser(name: "Developer")
        ```

        ### 数学公式支持
        行内公式：$E = mc^2$

        块级公式：
        $$
        \\sum_{i=1}^{n} x_i = x_1 + x_2 + \\cdots + x_n
        $$

        > 💡 **提示**：切换到"预览"模式查看渲染效果，或者点击底部的"聊天"标签与AI助手对话！
        """
        
        textView.text = sampleContent
        currentContent = sampleContent
    }
    
    @objc private func renderContent() {
        currentContent = textView.text
        renderMarkdown(currentContent)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            textView.isHidden = false
            webView.isHidden = true
            renderButton.isHidden = false

        case 1:
            textView.isHidden = true
            webView.isHidden = false
            renderButton.isHidden = true
            renderMarkdown(textView.text)

        default:
            break
        }
    }
    
    private func renderMarkdown(_ content: String) {
        do {
            let down = Down(markdownString: content)
            let html = try down.toHTML()
            
            let styledHTML = """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
                <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
                <script>
                    window.MathJax = {
                        tex: {
                            inlineMath: [['$', '$'], ['\\\\(', '\\\\)']],
                            displayMath: [['$$', '$$'], ['\\\\[', '\\\\]']]
                        }
                    };
                </script>
                <style>
                    body {
                        font-family: -apple-system, BlinkMacSystemFont, sans-serif;
                        line-height: 1.6;
                        color: #333;
                        padding: 20px;
                        background-color: #ffffff;
                    }
                    h1, h2, h3 { color: #2c3e50; margin-top: 24px; }
                    code {
                        background-color: #f8f9fa;
                        padding: 2px 6px;
                        border-radius: 3px;
                        font-family: 'SF Mono', Monaco, monospace;
                    }
                    pre {
                        background-color: #f8f9fa;
                        padding: 16px;
                        border-radius: 6px;
                        overflow-x: auto;
                    }
                    blockquote {
                        border-left: 4px solid #007AFF;
                        padding-left: 16px;
                        color: #666;
                        margin: 16px 0;
                    }
                    @media (prefers-color-scheme: dark) {
                        body { background-color: #1c1c1e; color: #ffffff; }
                        h1, h2, h3 { color: #ffffff; }
                        code { background-color: #2c2c2e; }
                        pre { background-color: #2c2c2e; }
                    }
                </style>
            </head>
            <body>\(html)</body>
            </html>
            """
            
            webView.loadHTMLString(styledHTML, baseURL: nil)
        } catch {
            let fallbackHTML = """
            <html><body style="font-family: -apple-system; padding: 20px;">
            <h3>渲染失败，显示原始内容：</h3>
            <pre>\(content.replacingOccurrences(of: "<", with: "&lt;"))</pre>
            </body></html>
            """
            webView.loadHTMLString(fallbackHTML, baseURL: nil)
        }
    }
}

// MARK: - Extensions

extension MarkdownRenderViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "mermaidReady" {
            print("Mermaid准备就绪")
        }
    }
}

extension MarkdownRenderViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView加载完成")
    }
}

extension MarkdownRenderViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 实时预览逻辑
    }
}
