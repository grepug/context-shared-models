import Foundation

public struct DeleteUserInput: CoSendable {
    public init() {}
}

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
    public let id: UUID
    public let modelName: String?
    public let deviceName: String?
    public let appVersion: String?
    public let appBuild: String?
    public let osVersion: String?
    public let osName: String?

    public init(id: UUID, modelName: String?, deviceName: String?, appVersion: String?, appBuild: String?, osVersion: String?, osName: String?) {
        self.id = id
        self.modelName = modelName
        self.deviceName = deviceName
        self.appVersion = appVersion
        self.appBuild = appBuild
        self.osVersion = osVersion
        self.osName = osName
    }
}
