// MARK: - VaultUnlockSetupAction

/// Actions that can be processed by a `VaultUnlockSetupProcessor`.
///
enum VaultUnlockSetupAction: Equatable {
    /// The set up later button was tapped.
    case setUpLater

    /// An unlock method was toggled on or off.
    case toggleUnlockMethod(VaultUnlockSetupState.UnlockMethod, newValue: Bool)
}
