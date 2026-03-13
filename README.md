# Thamanyah Task 

iOS app implementing a **backend-driven home screen** with multiple section types and search. Built with Swift, SwiftUI, and UIKit.

---

## Features

- **Backend-driven home** - Section types and order come from the API; the app parses the response and renders the matching view for each section type.
- **Multiple section layouts** - Square, Big Square, Two Lines Grid, Queue. Dedicated view for each.
- **Search** Search screen with unified results. Implemented in both ways, SwiftUI and UIKit.
- **Networking** - API client with models and custom decoding where the API varies (e.g., `order` as Int vs String)
- **Tests**  - Unit tests for ViewModels and decoding; UI tests for Home and Search screens.

---

## Tech Stack

- **SWift** . **SwiftUI** - Main UI
- **UIKit** - Embedded in SwiftUI and uses a SwiftUI view inside it to show both ways of integration between SwiftUI and UIKit. (e.g., Search screen)
- **SwiftTest** - For Unit tests
- **XCTest** - For UI tests

---

## Documentation

For a short problem summary, challenges, improvement ideas, and alignment with Thmanyah's identity, see **[Documentation.md](Documentation.md)** in English and العربية

---

## Author

Ahmad Ragab
