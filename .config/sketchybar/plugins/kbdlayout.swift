import Carbon
import Foundation

func currentSource() -> String {
    let source = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
    func property(_ key: CFString) -> String {
        Unmanaged<CFString>.fromOpaque(TISGetInputSourceProperty(source, key)!).takeUnretainedValue() as String
    }
    return "\(property(kTISPropertyInputSourceID))\t\(property(kTISPropertyLocalizedName))"
}

if CommandLine.arguments.contains("--watch") {
    DistributedNotificationCenter.default().addObserver(
        forName: Notification.Name(kTISNotifySelectedKeyboardInputSourceChanged as String),
        object: nil, queue: nil
    ) { _ in
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        task.arguments = ["sketchybar", "--trigger", "keyboard_change"]
        try? task.run()
    }
    RunLoop.main.run()
} else {
    print(currentSource())
}
