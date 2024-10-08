import Foundation

public struct AppVersion: CoSendable {
    public let version: String
    public let build: String

    public init(version: String, build: String) {
        self.version = version
        self.build = build
    }
}

public struct OSVersion: CoSendable {
    public let name: String
    public let version: String

    public init(name: String, version: String) {
        self.name = name
        self.version = version
    }
}

public struct DeleteUserInput: CoSendable {}

public struct CreateUserInfoInput: CoSendable {
    public let name: String
    public let created_at: Date
    public let deviceInfo: DeviceInfoInput

    public init(name: String, created_at: Date, deviceInfo: DeviceInfoInput) {
        self.name = name
        self.created_at = created_at
        self.deviceInfo = deviceInfo
    }
}

public struct DeviceInfoInput: CoSendable {
    public let id: String
    public let modelName: String?
    public let deviceName: String?
    public let appVersion: AppVersion?
    public let osVersion: OSVersion?

    init(id: String, modelName: String?, deviceName: String?, appVersion: AppVersion?, osVersion: OSVersion?) {
        self.id = id
        self.modelName = modelName
        self.deviceName = deviceName
        self.appVersion = appVersion
        self.osVersion = osVersion
    }
}
