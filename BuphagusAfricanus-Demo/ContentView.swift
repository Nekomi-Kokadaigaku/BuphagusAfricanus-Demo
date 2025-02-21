//
//  ContentView.swift
//  BuphagusAfricanus-Demo
//
//  Created by Iris on 2025-02-19.
//

import BuphagusAfricanus
import SwiftUI

struct ContentView: View {

    @State private var counter = 0 {
        didSet {
            baDebugState.shared.updateWatchVariable(
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
                
                Button("切换动画模式") {
                    withAnimation {
                        baWindowManager.shared.changeAnimationMode()
                    }
                }
                
                Button("显示调试窗口") {
                    withAnimation {
                        baWindowManager.shared.changeDebugWindowVisibility()
                    }
                }
                
                Button("测试信息") {
                    let bundle = Bundle.main

                    baDebugState.shared.info(
                        "应用信息",
                        details: """
                            名称: \(bundle.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown")
                            版本: \(bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown")
                            构建版本: \(bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown")
                            """
                    )
                }
            }
            .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            baGlobalConfig.shared.setDebugMode(true)
        }
    }
}

extension ContentView {

    /// 增加计数器
    private func incrementCounter() {
        counter += 1
        baDebugState.shared.userAction(
            "计数器增加到: \(counter)",
            details: "Button tapped at \(Date()) \(#file) \(#function) \(#line)"
        )
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
