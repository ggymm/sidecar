import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(windowDidResize),
      name: NSWindow.didResizeNotification,
      object: self
    )

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(windowDidEndLiveResize),
      name: NSWindow.didEndLiveResizeNotification,
      object: self
    )

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.forceButtonPositions()
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @objc private func windowDidResize() {
    forceButtonPositions()
  }

  @objc private func windowDidEndLiveResize() {
    DispatchQueue.main.async {
      self.forceButtonPositions()
    }
  }

  private func forceButtonPositions() {
    guard let closeButton = self.standardWindowButton(.closeButton),
          let miniaturizeButton = self.standardWindowButton(.miniaturizeButton),
          let zoomButton = self.standardWindowButton(.zoomButton) else {
      return
    }

    let xPos: CGFloat = 6.0
    let yPos: CGFloat = -6.0

    closeButton.setFrameOrigin(NSPoint(x: 12.0 + xPos, y: yPos))
    miniaturizeButton.setFrameOrigin(NSPoint(x: 32.0 + xPos, y: yPos))
    zoomButton.setFrameOrigin(NSPoint(x: 52.0 + xPos, y: yPos))
  }
}
