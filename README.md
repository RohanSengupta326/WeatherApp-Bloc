# Flutter Cubit Weather App

<p>
<img src="https://github.com/RohanSengupta326/WeatherApp-Bloc/assets/64458868/d298de28-2d47-490f-8f7a-ed2fcdc6853f" alt="Splash View" width="200">
<img src="https://github.com/RohanSengupta326/WeatherApp-Bloc/assets/64458868/ccfe0b6a-2b61-4aa8-aeb0-5eb47e726f1a" alt="Splash View" width="200">
<img src="https://github.com/RohanSengupta326/WeatherApp-Bloc/assets/64458868/2b47d54c-522b-42b4-9f8d-622e7a57bef5" alt="Splash View" width="200">
<img src="https://github.com/RohanSengupta326/WeatherApp-Bloc/assets/64458868/4ca1f2ba-0ecc-493e-85b8-e915072c2869" alt="Splash View" width="200">
</p>

## Description

This is a simple Flutter weather application built using the Cubit for state management. The app fetches weather data from an API and displays it in a user-friendly interface. It demonstrates how to structure a Flutter app with Cubit for efficient state management.

## Features

- **Current Weather**: View the current weather details, including temperature, weather conditions, and more.
- **Refresh**: Pull-to-refresh functionality to update weather data.
- **Responsive UI**: Responsive design that adapts to various screen sizes.

## Getting Started

### Prerequisites

``` 
Flutter 3.16.9 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 41456452f2 (4 days ago) • 2024-01-25 10:06:23 -0800
Engine • revision f40e976bed
Tools • Dart 3.2.6 • DevTools 2.28.5
```
**Dependecies**
```
  http: ^1.2.0
  bloc: ^8.1.2
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  intl: ^0.19.0
```


### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/RohanSengupta326/WeatherApp-Bloc

2. Navigate to the project folder:
   ```bash
   cd WeatherApp-Bloc

3. run
   ```bash
   flutter pub get

4. run the app :
   ```bash
   flutter run


### Cubit Architecture

The app follows the Cubit pattern for efficient state management. Key components include:

- **Cubit**: Handles the business logic and emits states in response to events.
- **Events**: Trigger actions that cause the Cubit to emit new states.
- **States**: Represent different states of the application (e.g., loading, loaded, error).



