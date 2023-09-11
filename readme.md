# SecureShellMaster

## Overview

SecureShellMaster is a robust command execution management system designed to provide granular control over who can execute what commands on a multi-user system. With a focus on security and flexibility, SecureShellMaster is ideal for environments where different users have varying levels of expertise and responsibility.

## Features

- **Client Interface**: A CLI tool or web interface for clients to request permissions.
- **Admin Interface**: A CLI tool or web interface for admins to approve or deny requests.
- **Centralized Server**: Manages all requests and permissions.
- **Database**: Stores the commands, permissions, and logs.
- **14 Types of Permissions**: From one-time authorized execution to geo-restricted authorization.
- **Secure Communication**: All communications are encrypted.

## Types of Permissions

1. **One-Time Authorized Execution (OTAE)**
2. **Permanent Authorized Execution (PAEN)**
3. **Timed Permanent Authorized Execution (TPAE)**
4. **Count-Restricted Authorization (CRA)**
5. **Elevated Temporary Authorization (ETA)**
6. **Group-Based Authorization (GBA)**
7. **Pre-Approved Command List (PACL)**
8. **Conditional Authorization (CA)**
9. **Geo-Restricted Authorization (GRA)**
10. **Chain-of-Command Authorization (CoCA)**
11. **Emergency Authorization (EA)**
12. **Audit-Only Authorization (AOA)**
13. **Revocable Authorization (RA)**
14. **Context-Sensitive Authorization (CSA)**
15. **AI Filtering (AIF)**

See [permissions.md](DOCS/permissions.md) for more details.

## Security Considerations

- **Authentication**: Both client and admin interfaces require secure authentication.
- **Authorization**: Only admins have the ability to approve or deny requests.
- **Logging**: All actions are logged for auditing purposes.
- **Secure Channels**: Utilizes encrypted channels for all communications.

## Web Site

Visit our [website](https://derekrnai.com) for more information.

## Installation

run `./install.sh` to install the program after cloning the repo to your local machine with `git clone https://github.com/dwerkjem/SecureShellMaster.git`.

## Usage

intended to be used with a linux system with ssh installed

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](DOCS/CONTRIBUTING.md) for more details.

## License

This project is licensed under the SecureShellMaster Commercial Limit License (SSMCLL). See the [LICENSE](LICENSE) file for details.

## AI Filtering

SecureShellMaster incorporates advanced AI algorithms to enhance its command filtering capabilities. This feature allows the system to:

- **Predictive Analysis**: Anticipate unauthorized or dangerous command attempts based on historical data.
- **Contextual Awareness**: Understand the context in which a command is being executed, improving the accuracy of its permission evaluations.
- **Anomaly Detection**: Identify unusual patterns or suspicious activities and flag them for review.
- **Adaptive Learning**: The system learns from user behavior and system states to continuously improve its filtering algorithms.

Note: The AI Filtering feature requires additional computational resources and may need specialized hardware for optimal performance.
