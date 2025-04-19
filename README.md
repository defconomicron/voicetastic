# Google Cloud API Access
    1. Navigate to https://console.cloud.google.com/
    2. Press CTRL + O
    3. Click "NEW PROJECT" link
    4. Name your project and click the CREATE button
    5. Click "SELECT PROJECT" link
    6. You should be on your newly created project
    7. Click the hamburger icon at the top left
    8. Hover over "APIs & Services"
    9. Click "Library"
    10. Search for "Text to Speech"
    11. Click "Cloud Text-to-Speech API"
    12. Click "ENABLE"
    13. Click "Library"
    14. Search for "Speech to Text"
    15. Click "Cloud Speech-to-Text API"
    16. Click "ENABLE"

# gcloud CLI Installation
    Linux Installation Instructions:
        https://cloud.google.com/sdk/docs/install#linux
        
    Windows 10 Installation Instructions:
        https://cloud.google.com/sdk/docs/install#windows
        
    Mac OS X Installation Instructions:
        https://cloud.google.com/sdk/docs/install#mac

# Git Installation
    Linux: https://git-scm.com/downloads/linux
    Windows: https://git-scm.com/downloads/win
    macOS: https://git-scm.com/downloads/mac

# Ruby Installation
    https://www.ruby-lang.org/en/downloads/

# Install Meshtastic CLI


# Install Voicetastic
    git clone git@github.com:defconomicron/voicetastic.git
    cd voicetastic
    bundle
    rake db:migrate

# Start up Voicetastic
    cd voicetastic
    rails server
    open http://127.0.0.1:3000

# Configure Voicetastic
    open http://127.0.0.1:3000
    Click the hamburger icon at top right
    Select desired voice to use
    Input the IP Address of your node
    Input your node's Long Name
    Input Meshtastic CLI path (typically meshtastic)
    Input Max Text Length (229 is recommended)
    Input channel names that your node is on. (One channel name per line)
