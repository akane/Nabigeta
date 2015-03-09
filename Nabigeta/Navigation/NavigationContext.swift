//
// This file is part of Nabigeta
//
// Created by JC on 22/12/14.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation
import UIKit

/**
* Provide contextual information for a navigation between two view controllers.
*
* During navigation this object is automatically created and passed to navigation strategies.
* You should not create any instance of this object by your own.
*
* Think about this object as a equivalent to UIViewControllerContextTransitioning but for navigation
*/
public class NavigationContext : NSObject {
    public typealias ClosureDestinationAvailable = (UIViewController) -> ()

    /// the view controller requiring navigation
    unowned public let sourceViewController: UIViewController
    /// the destination controller. This value is unknown until updateContext is called
    weak public private(set) var destinationViewController: UIViewController!

    public let route: Routable

    public private(set) var context: AnyObject?

    private var destinationCallback: ClosureDestinationAvailable?

    public init(source: UIViewController, route: Routable, context: AnyObject?) {
        self.sourceViewController = source
        self.route = route
        self.context = context
    }

    /**
    * Define the destination controller on the same navigation stack
    *
    * @param destination the destination view controller
    */
    public func updateContext(destination: UIViewController) {
        if (self.destinationViewController != nil) {
            return
        }

        self.destinationViewController = destination
        self.destinationCallback?(destination)
    }
}