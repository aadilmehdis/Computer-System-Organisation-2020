# Installation Instructions for GDB for Mac OSX

# Installing Homebrew: The Missing Package Manager for macOS (or Linux)

- Homebrew installs the stuff you need that Apple (or your Linux system) didn’t.
- You could learn more about it here 
- Execute the following command to install Homebrew on your system
    - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

# Installing GDB

- GDB is the GNU debugger tool
- Mac OSX uses the LLDB, the LLVM debugger, in their Xcode toolchain, so you will have to install the GDB tool yourself.
- Execute the following command to install GDB using Homebrew in your system,
    - `brew install gdb`
- Now you should have gdb install, but alas!, it won't work :(
- We need to code-sign the GDB executable, so it will be allowed to control other processes, as necessary for a debugger. For that, we will first create a new certificate in Keychain (onto the next section). 

# Codesigning
## Creating the Certificate with the right permissions
- Open Keychain Access application (cmd + Space -> Keychain Access)
- In Keychain Access select the "login" keychain in the "Keychains"
  list in the upper left hand corner of the window.
- Select the following menu item:
    - Keychain Access->Certificate Assistant->Create a Certificate...
- Set the following settings
    - Name = "gdb-cert"
    - Identity Type = Self Signed Root
    - Certificate Type = Code Signing
    - Click Create
    - Can customize the expiration date (3650 days = 10yrs)
    - Click Continue
    - Click Done
- Click on "My Certificates"
- Double click on your new "gdb-cert" certificate
- Turn down the "Trust" disclosure triangle, scroll to the "Code Signing" trust pulldown menu and select "Always Trust" and authenticate as needed using your username and password.
- Drag the new "gdb-cert" code signing certificate (not the public or private keys of the same name) from the "login" keychain to the "System" keychain in the Keychains pane on the left hand side of the main Keychain Access window. This will move this certificate to the "System" keychain. You'll have to authorize a few more times, set it to be "Always trusted" when asked.
- In the Keychain Access GUI, click and drag "gdb-cert" in the "System" keychain onto the desktop. The drag will create a "~/Desktop/gdb-cert.cer" file used in the next step.
- Switch to Terminal, and run the following:
    - `sudo security add-trust -d -r trustRoot -p basic -p codeSign -k /Library/Keychains/System.keychain ~/Desktop/gdb-cert.cer`
    - `rm -f ~/Desktop/gdb-cert.cer`
- Drag the "gdb-cert" certificate from the "System" keychain back into the "login" keychain (and maybe back again...?)
- Quit Keychain Access
- Reboot

## Checking the Certificate
- Show details about the certificate if found
    - `security find-certificate -c gdb-cert`
- Confirm that the certificate will not expire
    - `security find-certificate -p -c gdb-cert | openssl x509 -checkend 0`
- Show that the certificate has code signing trust setting enabled
    - `security dump-trust-settings -d`

## Creating the "entitlements.xml" File
- Copy the text below and save it in an "entitlements.xml" file in your current directory.
- ```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.cs.debugger</key>
    <true/>
</dict>
</plist>
```

## Signing the debugger binaries
- This step will link your newly created certificate with GDB
- Run the following commands in terminal:
    - Code sign with entitlements: `codesign --entitlements entitlements.xml -fs gdb-cert $(which gdb)`
    - Verify code signing: `codesign -vv $(which gdb)`
    - Display details of code signature: `codesign -d --entitlements - $(which gdb)`

## Refresh System Certificates
- Reboot the machine
