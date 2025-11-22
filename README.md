# Arithmetic Expressions Generator

A Flutter application that generates simple arithmetic expressions to use for exercising the basic arithmetic operations.

## Getting Started
To use the application, you need to have Flutter installed on your machine. 
If you don't have it, you can follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install).

After installing Flutter, you can clone the repository and run the application on your device or emulator.

## CI/CD Pipeline

This project includes a GitHub Actions CI/CD pipeline that automatically:
- Runs code analysis and tests on every push and pull request
- Builds a debug APK for every commit
- Creates releases with downloadable APKs when version tags are pushed

### Downloading APKs

**From Workflow Artifacts** (for any commit):
1. Go to the [Actions tab](../../actions)
2. Click on a workflow run
3. Download the `app-debug` artifact from the "Artifacts" section

**From Releases** (for tagged versions):
1. Go to the [Releases section](../../releases)
2. Download the APK from the latest release

### Creating a Release

To create a new release with an APK:
1. Create and push a version tag:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
2. The CI pipeline will automatically build the APK and create a release

## Screenshots
### Main menu
![img.png](docs/img.png)
### Arithmetic Expressions Generator.
Allows generating multiple expressions at once.
1. Also hides the different operands to make it more challenging.
2. Allows hiding only the result.
3. Allows changing the maximum operand value.

![img.png](docs/img1.png)

Provides a way to answer a generated expression in the app, only if a single expression was generated.

![img.png](docs/img2.png)
### Number Recognition
Allows recognizing numbers by counting a random number of objects.

![img.png](docs/img3.png)