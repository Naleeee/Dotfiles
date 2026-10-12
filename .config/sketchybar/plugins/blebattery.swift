// Prints "<name>\t<percent>" for each connected BLE device exposing the Battery Service
import CoreBluetooth
import Foundation

let batteryService = CBUUID(string: "180F")
let batteryLevel = CBUUID(string: "2A19")

final class Reader: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var central: CBCentralManager!
    // CoreBluetooth drops the connection if the peripherals are not retained
    var peripherals: [CBPeripheral] = []
    var remaining = 0

    override init() {
        super.init()
        central = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ c: CBCentralManager) {
        guard c.state == .poweredOn else {
            if c.state == .unauthorized || c.state == .poweredOff { exit(1) }
            return
        }
        peripherals = c.retrieveConnectedPeripherals(withServices: [batteryService])
        remaining = peripherals.count
        if remaining == 0 { exit(0) }
        for p in peripherals {
            p.delegate = self
            c.connect(p)
        }
    }

    func centralManager(_ c: CBCentralManager, didConnect p: CBPeripheral) {
        p.discoverServices([batteryService])
    }

    func centralManager(_ c: CBCentralManager, didFailToConnect p: CBPeripheral, error: Error?) {
        done()
    }

    func peripheral(_ p: CBPeripheral, didDiscoverServices error: Error?) {
        guard let s = p.services?.first(where: { $0.uuid == batteryService }) else { return done() }
        p.discoverCharacteristics([batteryLevel], for: s)
    }

    func peripheral(_ p: CBPeripheral, didDiscoverCharacteristicsFor s: CBService, error: Error?) {
        guard let ch = s.characteristics?.first(where: { $0.uuid == batteryLevel }) else { return done() }
        p.readValue(for: ch)
    }

    func peripheral(_ p: CBPeripheral, didUpdateValueFor ch: CBCharacteristic, error: Error?) {
        if let level = ch.value?.first { print("\(p.name ?? "unknown")\t\(level)") }
        done()
    }

    func done() {
        remaining -= 1
        if remaining <= 0 { exit(0) }
    }
}

let reader = Reader()
DispatchQueue.main.asyncAfter(deadline: .now() + 5) { exit(0) }
RunLoop.main.run()
