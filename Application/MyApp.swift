import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                MainView()
                    .environment(\.mainWindowSize, proxy.size)
            }
            
        }
    }
}

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
