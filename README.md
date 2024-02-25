# Fridge Spy

Fridge Spy is a mobile application developed with Flutter, designed to help reduce food waste by
tracking the items in your fridge along with their expiry dates. This simple yet effective app
provides a clear overview of your fridge contents, ensuring you're always aware of which items need
to be consumed to prevent waste.

## Features

- Expiry Tracking: Home screen displays a list of items expiring in the next three days, prompting
  timely consumption or utilization.
- Comprehensive Food List: A detailed view of all food items currently stored in your fridge, with
  functionalities to add new items as needed.
- Barcode Scanning: Integration with an external food database API allows for barcode scanning. If
  the
  scanned item is found in the database, the app automatically fills in the food name and displays
  an
  image, simplifying item entry.
- Reduce Food Waste: By keeping a vigilant eye on expiry dates, Fridge Spy aids in minimizing food
  wastage, encouraging a more sustainable lifestyle.

## Libraries Used

- Firebase Cloud Firestore: Utilized as the primary database for storing information about fridge
  items and their expiry dates. Firebase Cloud Firestore offers a flexible, scalable database for
  mobile, web, and server development from Firebase and Google Cloud Platform.
- Flutter Barcode Scanner: This library is used to implement barcode scanning functionality,
  allowing users to easily add new items to their fridge list by scanning product barcodes.
- Riverpod: A state management library that provides a clean and efficient way to manage the app's
  state, ensuring the user interface remains responsive and up-to-date with the underlying data.
- HTTP Package: Used for making HTTP requests to the external food database API. This package
  facilitates communication with web services, enabling the app to retrieve food item details based
  on barcodes.
- Flutter Dotenv: Allows for the dynamic configuration of environment variables, such as API keys
  for the external API, ensuring sensitive information is managed securely and efficiently.
- Flutter Launcher Icons (Dev Dependency): A development dependency that aids in the creation of
  custom launcher icons for the app, enhancing its visual identity and user experience.

## App Architecture

The architecture of Fridge Spy is organized into five main packages, each serving a distinct purpose
in the app's overall structure and functionality:

- Config Package: Contains the Firebase options for the app's backend integration, along with the
  color scheme definitions for the app's theme. This package centralizes configuration settings,
  ensuring a consistent look and feel across the app.
- Models Package: Houses all the data models used within the app. These models define the structure
  of
  the data, such as fridge items and their attributes, ensuring a robust and scalable data
  management
  system.
- Provider Package: All the state management logic resides here, using Riverpod providers. This
  package is key to managing app state, facilitating efficient and reactive data flow throughout the
  app.
- Services Package: Includes the logic for external interactions, such as HTTP requests to the
  external API and interactions with Firebase Cloud Firestore. This package abstracts away the
  complexities of external communications, providing clean and reusable service classes.
- Views Package: Contains all the widgets and UI elements of the app. This package is responsible
  for
  rendering the user interface, based on the current app state and data models, to provide a
  seamless
  user experience.

## State Management

In Fridge Spy, state management is kept simple and efficient:

- Local State Management: Flutter's built-in state management is used for handling local and simple
  states within the app. This approach is ideal for managing states that are confined to specific
  widgets or components.
- RiverPod Integration: For more complex state management tasks, Fridge Spy utilizes the RiverPod
  package, which is an evolution of the provider package. RiverPod's latest features, including
  code-generated providers, are employed to streamline state management and ensure optimal
  performance.
- Firebase Integration: With Firebase, comprehensive state management is not required as Firebase
  offers built-in options for real-time data synchronization. By using listeners, data is
  automatically updated whenever changes occur, such as adding or deleting items, even across
  different devices. This real-time streaming ensures that Flutter widgets are automatically
  refreshed to reflect the latest data.

## Firebase Integration

Fridge Spy harnesses the power of Firebase for seamless data management and synchronization:

- Firestore Database: Firebase Firestore serves as the backbone of the app's data storage, providing
  a reliable and scalable solution for storing fridge items and their expiry dates. The app utilizes
  Firestore's real-time and offline capabilities to ensure that data is always up-to-date and
  accessible, even when offline, with automatic synchronization upon reconnection.
- Real-time Functionality: Leveraging Firebase's real-time functionality, Fridge Spy enables live
  updates across all devices. Any changes made to the data are instantly synchronized with
  Firestore,
  ensuring consistency and real-time collaboration.
- Sorting and Filtering: Firebase Firestore's powerful querying capabilities are employed to
  implement sorting and filtering functionalities within the app. This allows users to efficiently
  organize and view their fridge items based on various criteria.
- Data Conversion: Fridge Spy seamlessly converts data between Firestore documents and app models,
  facilitating smooth communication between the app and the Firestore database. This ensures that
  data
  is accurately represented and managed throughout the application.