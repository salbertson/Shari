//
//  Shari.swift
//  Pods
//
//  Created by nakajijapan on 2015/12/24.
//
//

import Foundation

@available(*, unavailable, renamed: "ShariSettings.backgroundColorOfOverlayView")
public var BackgroundColorOfOverlayView: UIColor = { fatalError() }()

@available(*, unavailable, renamed: "ShariSettings.shouldTransformScaleDown")
public var ShouldTransformScaleDown: Bool = { fatalError() }()

public struct ShariSettings {
    public static var shouldTransformScaleDown = true
    public static var backgroundColorOfOverlayView = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
}

public protocol ShariCompatible {
    associatedtype CompatibleType

    static var si: Shari<CompatibleType>.Type { get set }
    var si: Shari<CompatibleType> { get set }
}

public final class Shari<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }

    func bothEndsViewControllers(viewController: UIViewController?, childViewControllers: [UIViewController]) -> (UIViewController?, UIViewController?) {
        guard let visibleViewController = viewController else {
            return (nil, nil)
        }

        weak var sourceViewController = visibleViewController

        guard let index = childViewControllers.index(of: visibleViewController) else {
            return (sourceViewController, nil)
        }

        weak var destinationViewController = childViewControllers[index - 1]

        return (sourceViewController, destinationViewController)
    }
}

public extension ShariCompatible {

    public static var si: Shari<Self>.Type {
        get {
            return Shari<Self>.self
        }
        set {}
    }

    public var si: Shari<Self> {
        get {
            return Shari(self)
        }
        set {}
    }
}

extension UINavigationController: ShariCompatible { }
extension UITabBarController: ShariCompatible { }

