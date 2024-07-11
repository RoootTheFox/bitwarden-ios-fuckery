// MARK: - CheckEmailProcessor

/// The processor used to manage state and handle actions for the passwort hint screen.
///
class CheckEmailProcessor: StateProcessor<CheckEmailState, CheckEmailAction, CheckEmailEffect> {
    // MARK: Private Properties

    /// The coordinator that handles navigation.
    private let coordinator: AnyCoordinator<AuthRoute, AuthEvent>

    // MARK: Initialization

    /// Creates a new `CheckEmailProcessor`.
    ///
    /// - Parameters:
    ///   - coordinator: The coordinator that handles navigation.
    ///   - state: The initial state of the processor.
    ///
    init(
        coordinator: AnyCoordinator<AuthRoute, AuthEvent>,
        state: CheckEmailState
    ) {
        self.coordinator = coordinator
        super.init(state: state)
    }

    // MARK: Methods

    override func perform(_ effect: CheckEmailEffect) async {}

    override func receive(_ action: CheckEmailAction) {
        switch action {
        case .dismissTapped,
             .logInTapped:
            coordinator.navigate(to: .dismiss)
        case .goBackTapped:
            coordinator.navigate(to: .dismissPresented)
        }
    }
}
