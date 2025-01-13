
# CI/CD Pipeline Process for Habit Hub

## Overview

The **CI/CD pipeline** automates the process of building, testing, and deploying the **Habit Hub** project. The pipeline is powered by **GitHub Actions** and integrates with **Firebase Hosting** to deploy the web app. Additionally, it builds and stores the **APK** for mobile apps.

### Key Components of the CI/CD Pipeline

1. **Continuous Integration (CI)**:
    - Automates the process of building the app and ensuring that the latest changes are correctly integrated.
    - Includes building both the **Flutter APK** (Android app) and the **web app**.

2. **Continuous Deployment (CD)**:
    - Automatically deploys the web app to **Firebase Hosting** and uploads the latest **APK** to **GitHub Artifacts**.
    - Ensures that every change pushed to the `main` branch is reflected on Firebase Hosting and the latest APK is available for download.

## Workflow

The pipeline is triggered when code is pushed to the `main` branch. Here is the process:

### 1. **Triggering the Pipeline**
- Every time you push changes to the `main` branch in the repository, the GitHub Actions pipeline is triggered.

### 2. **Checkout the Repository**
- The pipeline starts by checking out the latest code from the GitHub repository using the `actions/checkout@v3` GitHub action.

### 3. **Set Up Flutter Environment**
- The next step is setting up the **Flutter** environment in the CI pipeline using the `subosito/flutter-action@v2` action.
- The `flutter-version: stable` configuration ensures that the stable version of Flutter is used.

### 4. **Install Dependencies**
- The pipeline runs `flutter pub get` to install all the dependencies defined in the `pubspec.yaml` file. This ensures that all necessary packages are installed for the build process.

### 5. **Build APK**
- The pipeline then runs `flutter build apk --release` to build the **APK** for the Android app. This is done in release mode to ensure the APK is optimized for production.
- The APK is generated in the `build/app/outputs/flutter-apk/` directory.

### 6. **Build Web App**
- The next step is building the **web app** using the command `flutter build web`. This command compiles the Flutter app for the web platform, generating the build output in the `build/web` directory.

### 7. **Upload APK to GitHub Artifacts**
- The built **APK** file is uploaded as an artifact to GitHub using the `actions/upload-artifact@v3` action. This allows you to download the latest APK directly from the GitHub Actions interface.

### 8. **Deploy Web App to Firebase Hosting**
- The final step in the pipeline is deploying the web app to **Firebase Hosting**.
- This is done using the Firebase CLI (`firebase deploy --only hosting`).
- To authenticate the Firebase deployment, the **Firebase Authentication Token** is retrieved securely from GitHub secrets using the environment variable `FIREBASE_TOKEN`.

### Firebase Hosting Configuration

To ensure the Firebase Hosting deployment works correctly, the **firebase.json** configuration file must be set up. Here's an example configuration:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

This configuration specifies that the web app is located in the `build/web` directory and includes rewrite rules to route all requests to `index.html`, which is necessary for single-page applications (SPA).

## Summary of CI/CD Pipeline Process

1. **Push Code to `main`**: A push to the `main` branch triggers the pipeline.
2. **Checkout Repository**: The latest code is checked out.
3. **Set Up Flutter**: Flutter is set up in the CI environment.
4. **Install Dependencies**: Dependencies are installed using `flutter pub get`.
5. **Build APK**: The APK for the Android app is built in release mode.
6. **Build Web App**: The web version of the app is built.
7. **Upload APK**: The built APK is uploaded as an artifact for easy access.
8. **Deploy Web App**: The web app is deployed to Firebase Hosting.

## Monitoring the CI/CD Pipeline

- **GitHub Actions**: You can monitor the status of the CI/CD pipeline by going to the **Actions** tab in your GitHub repository. Here, you can see the progress of each step and check the logs for any errors.
- **Firebase Hosting**: Firebase provides logs of the deployment process under the **Hosting** section of the Firebase Console. This allows you to track the success or failure of each deployment.

## Firebase Authentication Token

The Firebase Authentication Token is used to authenticate the deployment to Firebase Hosting. To get the token, run the following command in your local terminal:

```bash
firebase login:ci
```

This command will open a browser window where you can log in to your Firebase account. After logging in, you will receive a token, which you should add to your GitHub repository secrets as `FIREBASE_TOKEN`.

## Conclusion

The CI/CD pipeline ensures that every time you push changes to the `main` branch, the latest APK is built and deployed, and the web app is deployed to Firebase Hosting. This automated process reduces the risk of errors, speeds up the development cycle, and ensures that the latest version of your app is always available to users.
