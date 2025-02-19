//
//  ContentView.swift
//  BuphagusAfricanus-Demo
//
//  Created by Iris on 2025-02-19.
//

import SwiftUI
import BuphagusAfricanus

/// 主窗口视图
struct ContentView: View {
//    let windowId: String

    /// 调试状态对象
    @ObservedObject var debugState: baDebugState = .shared
    @ObservedObject var manager = baWindowManager.shared
    @State private var counter = 0 {
        didSet {
            debugState.updateWatchVariable(
                name: "counter", value: counter, type: "Int")
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("计数器: \(counter)")
                .font(.title)

            // 控制区域
            VStack(spacing: 12) {
                // 增加计数按钮
                Button("增加计数") {
                    incrementCounter()
                }

                // 重置窗口位置按钮
                Button("重置窗口位置") {
                    baWindowManager.shared.snapDebugWindowToMain()
                }
//                Button("切换动画模式") {
//                    withAnimation {
//                        manager.windowMode =
//                            manager.windowMode == .animation
//                            ? .direct : .animation
//                    }
//                }
//                .buttonStyle(baMainWindowButtonStyle(color: .blue))
                Button("显示调试窗口") {
//                    withAnimation {
//                        if manager.debugWindow?.isVisible ?? false {
//                            manager.debugWindow?.orderOut(nil)
//                        } else {
//                            manager.debugWindow?.makeKeyAndOrderFront(nil)
//                            manager.mainWindow?.makeKeyAndOrderFront(nil)
//                        }
//                    }
                }
//                .buttonStyle(baMainWindowButtonStyle(color: .blue))
                Button("测试信息") {
                    // 添加应用信息
                    let bundle = Bundle.main
                    #if DEVELOPMENT
                        debugState.info(
                            "应用信息",
                            details: """
                                名称: \(bundle.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown")
                                版本: \(bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown")
                                构建版本: \(bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown")
                                """
                        )
                    #endif
                }
//                .buttonStyle(baMainWindowButtonStyle(color: .red))
            }
            .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

extension ContentView {
    /// 增加计数器
    private func incrementCounter() {
        counter += 1
        #if DEBUG
//            debugState.userAction(
//                "计数器增加到: \(counter)\(baMainWindowDelegate.shared.getIdentifier())",
//                details:
//                    "Button tapped at \(Date()) \(#file) \(#function) \(#line)"
//            )
        #endif
    }
}


public struct baWindowGroup<Content: View>: Scene {
    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some Scene {
        WindowGroup {
            content()
                .frame(width: 300, height: 500)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .onAppear {
                    let a = NSApplication.shared.windows.first
                    a!.isMovableByWindowBackground = true
                    a!.title = "123"
                }
        }
        .windowResizability(.contentSize)
    }
}
