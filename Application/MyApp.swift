import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                MainView()
                    .environment(
                        \.mainWindowSize,
                         CGSize(
                            width: proxy.size.width,
                            height: proxy.size.height
                            + proxy.safeAreaInsets.top
                            + proxy.safeAreaInsets.bottom
                         )
                    )
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
