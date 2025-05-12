# Chuck Norris Facts CLI

A simple command-line tool that fetches random Chuck Norris facts.
You can receive facts anywhere.

## Features

- Fetch random Chuck Norris facts from the [Chuck Norris Jokes Api](https://api.chucknorris.io/)
- Replace "Chuck Norris" with any name of your choice
- Easy to use from the command line
- Support only Windows now

## Installation

1. Make sure Python is installed on your system
2. Clone this repo
3. Run the setup script:
    ```
    .\setup.bat
    ```
4. The setup will:
    - Add the program directory to your PATH environment variable
    - Create the necessary files for command-line execution

## Usage

### Basic Usage
```
fact
```

This will display a random Chuck Norris fact.

### Custom Name
```
fact "Kenshi Takada"
```

This will display a random fact with "Chuck Norris" replaced by "Kenshi Takada".

## Requirements

- Python 3.x
- `requests` library (automatically installed during setup)

## How It Works

The program connects to the Chuck Norris API, fetches a random fact, and displays it in your terminal. When you provide a name, it replaces all occurrences of "Chuck Norris" with that name.

## Troubleshooting

- If you see `'python' is not recognized as an internal or external command`, make sure Python is installed and added to your PATH.
- You may need to restart your command prompt after installation for PATH changes to take effect.

## License

This project is open source and available under the MIT License.
