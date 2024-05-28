# TaskTastic

Welcome to TaskTastic! This is an iOS app designed to help you organise your tasks efficiently. With TaskTastic, you can create to-do lists, categorise your tasks, and enjoy a vibrant, colourful UI.

## Features

- **Categorised To-Do Lists**: Create different categories and add tasks to each category.
- **Swipe to Delete**: Easily delete tasks with a swipe gesture, thanks to SwipeCellKit.
- **Vibrant UI**: Enjoy a visually appealing app with dynamic colours, powered by ChameleonFramework.
- **Data Persistence**: Your data is securely stored using the Realm Swift framework.

## Screenshots

<img width="359" alt="Screenshot 2024-05-28 at 12 17 44" src="https://github.com/RohinMaddy/TaskTastic/assets/40590725/930e21da-e3c0-486f-a2df-b774de9ba9be">

<img width="358" alt="Screenshot 2024-05-28 at 12 18 11" src="https://github.com/RohinMaddy/TaskTastic/assets/40590725/8c3e1d83-40a8-4a5f-8ec6-b530828f4454">

## Requirements

- iOS 16.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/RohinMaddy/TaskTastic.git
    ```

2. Navigate to the project directory:

    ```bash
    cd TaskTastic
    ```

3. Open the project in Xcode:

    ```bash
    open TaskTastic.xcodeproj
    ```

4. Install the dependencies using CocoaPods. Run the following command in your terminal:

    ```bash
    pod install
    ```

5. Open the `.xcworkspace` file in Xcode:

    ```bash
    open TaskTastic.xcworkspace
    ```

6. Build and run the project on your desired simulator or device.

## Frameworks Used

### Realm Swift
Realm Swift is used for data persistence. It ensures that your tasks and categories are saved locally on your device.

### SwipeCellKit
SwipeCellKit is used to implement swipe actions on table view cells. This allows you to delete tasks with a simple swipe gesture.

### ChameleonFramework
ChameleonFramework is used to add vibrant colors to the app's UI, making it more engaging and visually appealing.

## Usage

1. **Add a Category**: Start by adding a new category for your tasks.
2. **Create Tasks**: Within each category, you can create tasks.
3. **Swipe to Delete**: Swipe left on a task to delete it.
4. **Customise UI**: Enjoy the colorful interface that adapts to your preferences.

---
