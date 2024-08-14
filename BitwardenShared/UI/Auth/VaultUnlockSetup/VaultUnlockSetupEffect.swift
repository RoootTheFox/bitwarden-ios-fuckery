// MARK: - VaultUnlockSetupEffect

/// Effects handled by the `VaultUnlockSetupProcessor`.
///
enum VaultUnlockSetupEffect: Equatable {
    /// The continue button was tapped.
    case continueFlow

    /// Any initial data for the view should be loaded.
    case loadData
}
