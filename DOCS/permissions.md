# Types of Permissions in a Nuanced Command Execution System

## 1. One-Time Authorized Execution (OTAE)

Allows a user to execute a specific command within a given time frame. Admin is notified at the time of execution.

## 2. Permanent Authorized Execution (PAEN)

Allows a user to execute a specific command indefinitely. Admin is notified at the time of execution.

## 3. Timed Permanent Authorized Execution (TPAE)

Allows a user to execute a specific command indefinitely but within a specific time window each day.

## 4. Count-Restricted Authorization (CRA)

Allows a user to execute a command only a limited number of times.

## 5. Elevated Temporary Authorization (ETA)

Requires two-factor authentication (2FA) each time the command is executed, even after admin approval.

## 6. Group-Based Authorization (GBA)

Commands can only be executed if a certain number of users from a designated group approve.

## 7. Pre-Approved Command List (PACL)

Users can freely execute commands from a pre-approved list. Each execution is logged and reviewed periodically.

## 8. Conditional Authorization (CA)

Commands can only be executed if certain conditions are met, like system metrics or the status of other system services.

## 9. IP-Restricted Authorization (IpRA)

Commands can only be executed from certain IP addresses.

## 10. Chain-of-Command Authorization (CoCA)

Requires multiple levels of approval before a command can be executed.

## 11. Emergency Authorization (EA)

In emergency situations, commands can be executed immediately but require post-execution review.

## 12. Audit-Only Authorization (AOA)

Commands cannot be executed but can be audited to see what would happen if they were.

## 13. Revocable Authorization (RA)

Permission can be granted but is easy to revoke if needed.

## 14. Context-Sensitive Authorization (CSA)

Commands are allowed or disallowed based on the current system context, such as during certain system states or when certain applications are running.

## 15. AI Filtering (AIF)

AI is used to filter out commands that are likely to be malicious or dangerous. i.e. `rm -rf /` and `sudo rm -rf /` are both blocked on all permissions by default. and other commands will notify the admin that they are deemed potentially dangerous by the AI this could be before or after execution depending on how dangerous it is deemed.
Beneficial for an extra layer of security, particularly against both known and emerging threats.
