//
/*
 * Copyright (c) 2016, Nordic Semiconductor
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Foundation
import CoreBluetooth

/// UUID Types for DFU
@objc public enum DFUUuidType: Int {
    /// Legacy DFU Service
    case lagacyService                  = 0
    /// Legacy DFU Control Point Characteristic
    case legacyControlPoint             = 1
    /// Legacy DFU Packet Characteristic
    case legacyPacket                   = 2
    /// Legacy DFU Version Characteristic
    case legacyVersion                  = 3
    /// Secure DFU Service
    case secureService                  = 4
    /// Secure DFU Control Characteristic
    case secureControl                  = 5
    /// Secure DFU Packet Characteristic
    case securePacket                   = 6
    /// Buttonless DFU Service
    case buttonlessService              = 7
    /// Buttonless DFU Characteristic
    case buttonlessCharacteristic       = 8
    /// Buttonless DFU Without Bond Sharing Characterisitic
    case buttonlessWithoutBondSharing   = 9
    /// Buttonless DFU With Bond Sharing Characterisitic
    case buttonlessWithBondSharing      = 10
}

/// DFU UUID object
@objc public class DFUUuid: NSObject {

    /// UUID For the DFU UUID Object
    @objc
    public let uuid: CBUUID

    /// Type of DFU UUID
    @objc
    public let type: DFUUuidType

    @objc
    public init(withUUID: CBUUID, forType: DFUUuidType) {

        self.uuid = withUUID
        self.type = forType

        super.init()
    }
}

/// UUID Helper for DFU Process
///
/// The UUID can be modified for each of the DFU types supported by
/// the Nordic devices.
@objc public class DFUUuidHelper: NSObject {

    /// UUID for Legacy DFU Service
    @objc
    private(set) public var legacyDFUService: CBUUID

    /// UUID for Legacy DFU Control Point Characteristic
    @objc
    private(set) public var legacyDFUControlPoint: CBUUID

    /// UUID for Legacy DFU Packet Characteristic
    @objc
    private(set) public var legacyDFUPacket: CBUUID

    /// UUID for Legacy DFU Version Characteristic
    @objc
    private(set) public var legacyDFUVersion: CBUUID

    /// UUID for Secure DFU Service
    @objc
    private(set) public var secureDFUService: CBUUID

    /// UUID for Secure DFU Control Characteristic
    @objc
    private(set) public var secureDFUControlPoint: CBUUID

    /// UUID for Secure DFU Packet Characteristic
    @objc
    private(set) public var secureDFUPacket: CBUUID

    /// UUID for Buttonless DFU Service
    ///
    /// This UUID is also used for the Characteristic
    @objc
    private(set) public var buttonlessExperimentalService: CBUUID

    /// UUID for Buttonless DFU Characteristic
    @objc
    private(set) public var buttonlessExperimentalCharacteristic: CBUUID

    /// UUID for Buttonless DFU Without Bond Sharing Characterisitic
    @objc
    private(set) public var buttonlessWithoutBonds: CBUUID

    /// UUID for Buttonless DFU With Bond Sharing Characterisitic
    @objc
    private(set) public var buttonlessWithBonds: CBUUID

    /// Creates the DFU Helper with Default UUIDs
    @objc
    public override init() {
        // setup the default UUIDs
        
        ///
        /// Legacy DFU
        ///
        self.legacyDFUService = CBUUID(string: "00001530-1212-EFDE-1523-785FEABCD123")
        self.legacyDFUControlPoint = CBUUID(string: "00001531-1212-EFDE-1523-785FEABCD123")
        self.legacyDFUPacket = CBUUID(string: "00001532-1212-EFDE-1523-785FEABCD123")
        self.legacyDFUVersion = CBUUID(string: "00001534-1212-EFDE-1523-785FEABCD123")

        ///
        /// Secure DFU
        ///
        self.secureDFUService = CBUUID(string: "FE59")
        self.secureDFUControlPoint = CBUUID(string: "8EC90001-F315-4F60-9FB8-838830DAEA50")
        self.secureDFUPacket = CBUUID(string: "8EC90002-F315-4F60-9FB8-838830DAEA50")

        ///
        /// Buttonless DFU
        ///
        self.buttonlessExperimentalService = CBUUID(string: "8E400001-F315-4F60-9FB8-838830DAEA50")
        // the same UUID as the service by default
        self.buttonlessExperimentalCharacteristic = CBUUID(string: "8E400001-F315-4F60-9FB8-838830DAEA50")

        self.buttonlessWithoutBonds = CBUUID(string: "8EC90003-F315-4F60-9FB8-838830DAEA50")
        self.buttonlessWithBonds = CBUUID(string: "8EC90004-F315-4F60-9FB8-838830DAEA50")

        super.init()
    }

    @objc
    /// Create the DFU UUID Helper with Custom UUIDs
    ///
    /// - Parameter uuids: Array of Custom UUIDs
    public convenience init(customUuids uuids: [DFUUuid]) {

        self.init()

        for uuid in uuids {

            switch uuid.type {
            case .lagacyService:
                self.legacyDFUService = uuid.uuid
            case .legacyControlPoint:
                self.legacyDFUControlPoint = uuid.uuid
            case .legacyPacket:
                self.legacyDFUPacket = uuid.uuid
            case .legacyVersion:
                self.legacyDFUVersion = uuid.uuid
            case .secureService:
                self.secureDFUService = uuid.uuid
            case .secureControl:
                self.secureDFUControlPoint = uuid.uuid
            case .securePacket:
                self.secureDFUPacket = uuid.uuid
            case .buttonlessService:
                self.buttonlessExperimentalService = uuid.uuid
            case .buttonlessCharacteristic:
                self.buttonlessExperimentalCharacteristic = uuid.uuid
            case .buttonlessWithoutBondSharing:
                self.buttonlessWithoutBonds = uuid.uuid
            case .buttonlessWithBondSharing:
                self.buttonlessWithBonds = uuid.uuid
            }
        }

    }

}

internal extension DFUUuidHelper {

    /// Checks if the Characteristic matches the ButtonLess Characteristics
    ///
    /// - Parameters:
    ///   - characteristic: Characteristic to check for match
    ///   - helper: Instance of the UUID Helper
    /// - Returns: Bool Value
    internal static func matchesButtonLess(_ characteristic: CBCharacteristic, helper: DFUUuidHelper) -> Bool {
        return characteristic.uuid.isEqual(helper.buttonlessWithBonds) ||
            characteristic.uuid.isEqual(helper.buttonlessWithoutBonds) ||
            characteristic.uuid.isEqual(helper.buttonlessExperimentalCharacteristic)
    }

    /// Checks if the Characteristic matches the DFU UUID
    ///
    /// - Parameters:
    ///   - characteristic: Characteristic to check for match
    ///   - uuid: DFU UUID
    /// - Returns: Bool Value
    internal static func matches(_ characteristic: CBCharacteristic, uuid: CBUUID) -> Bool {
        return characteristic.uuid.isEqual(uuid)
    }

    /// Checks if the Service matches the DFU UUID
    ///
    /// - Parameters:
    ///   - service: Service to check for match
    ///   - uuid: DFU UUID
    /// - Returns: Bool Value
    internal static func matches(_ service: CBService, uuid: CBUUID) -> Bool {
        return service.uuid.isEqual(uuid)
    }

}
