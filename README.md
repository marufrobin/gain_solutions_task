# Gain Solutions Task - Flutter Application

This project is a Flutter application demonstrating various software engineering practices, including state management with BLoC, navigation with GoRouter, and a structured approach to feature development.

## Implementation Approach

The application follows a clean architecture inspired by the BLoC (Business Logic Component) pattern and a Repository pattern for data handling.

### Key Architectural Components:

*   **BLoC (Business Logic Component):** Each major feature (Tickets, Contacts, Profile) has its own BLoC to manage its state and business logic. This ensures a clear separation of concerns and testability.
*   **Repository Pattern:** A `Repository` layer acts as an abstraction over data sources. It provides a clean API for BLoCs to interact with data without knowing the underlying implementation details (e.g., whether data comes from a local database, a network API, or mock data).
*   **Data Providers:** `Data Providers` are responsible for fetching and manipulating raw data from specific sources. The `Repository` uses one or more `Data Providers` to fulfill its data requests.
*   **GoRouter for Navigation:** The application uses `go_router` for declarative routing, making navigation within the app predictable and easy to manage.


### Feature Breakdown:

*   **Splash Screen:** An initial loading screen.
*   **Dashboard Screen:**
    *   Hosts a bottom navigation bar for switching between main features.
    *   Uses `DashboardNavStateCubit` to manage the selected tab.
*   **Tickets Screen:**
    *   Displays a list of tickets.
    *   Includes filtering capabilities by brand, priority, and tags.
    *   Utilizes `TicketsBloc` for state management and `TicketsRepository` for data.
    *   Integrates `AppTimeFormaterUtils` for consistent date and time display.
*   **Contacts Screen:**
    *   Displays a list of contacts.
    *   Features a search bar to filter contacts by name.
    *   Provides actions for each contact via a `PopupMenuButton`.
    *   Uses `ContactsBloc` for state management and `ContactsRepository` for data.
*   **Profile Screen:**
    *   Displays user profile information.
    *   Includes a section for assigned roles.
    *   Uses `ProfileBloc` for state management and `ProfileRepository` for data.
*   **Filter Screen:**
    *   A dedicated screen for applying filters to the ticket list.
    *   Allows filtering by `TicketBrand`, `TicketPriority`, and `tags`.

### Utility Classes:

*   **`AppTimeFormaterUtils`:** A utility class for formatting `DateTime` objects into a user-friendly string format.
*   **`AppAssetsPath`:** Centralized paths for all application assets (SVG icons, images).
*   **`AppRoutes` and `AppRoutesNames`:** Centralized routing configuration for `go_router`.
*   **`AppBlocProviderResolver`:** Centralized BLoC provider resolution for widget trees.

## Getting Started

To run this project locally:

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd gain_solutions_task
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the application:**
    ```bash
    flutter run
    ```

---