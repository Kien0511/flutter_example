import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CBCentralManagerDelegate {
    
    var isBluetoothPermissionGranted: Bool {
           if #available(iOS 13.1, *) {
               return CBCentralManager.authorization == .allowedAlways
           } else if #available(iOS 13.0, *) {
               return CBCentralManager().authorization == .allowedAlways
           }
           // Before iOS 13, Bluetooth permissions are not required
           return true

       }

        

        func centralManagerDidUpdateState(_ central: CBCentralManager) {
            switch central.state {
                   case .poweredOn:
                       break
                   case .poweredOff:
                       break
                   default:
                       break
                   }
            print(central.state)
        }

    @available(iOS 13.0, *)
    func checkPermission() -> CBManagerAuthorization {
           if #available(iOS 13.1, *) {
             return checkPermissionBeforeCBManagerAllocation()
           } else {
             return checkPermissionLegacy()
           }
         }

     @available(iOS 13.1, *)
     private func checkPermissionBeforeCBManagerAllocation() -> CBManagerAuthorization {
       CBCentralManager.authorization
     }

    @available(iOS 13.0, *)
    private func checkPermissionLegacy() -> CBManagerAuthorization {
        let manager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: 1])
       return manager.authorization
     }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 13.0, *) {
        self.checkPermission()
    } else {
        CBPeripheralManager.authorizationStatus()
    }
    if #available(iOS 13.0, *) {
        self.checkPermissionLegacy()
    } else {
        CBPeripheralManager.authorizationStatus()
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
