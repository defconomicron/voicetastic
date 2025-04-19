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
    https://cloud.google.com/sdk/docs/install

# Log into gcloud CLI in Linux / macOS
    Run console command: gcloud auth login
    Your web browser should open and be taken to log into your Google Cloud account

# Set gcloud default project in Linux / macOS
    Run console command: gcloud auth application-default login
    A list of projects should appear in the console.
    Select the project name you created from the list.

# Git Installation
    https://git-scm.com/downloads

# Ruby Installation
    https://www.ruby-lang.org/en/downloads/

# Install Meshtastic CLI
    https://meshtastic.org/docs/software/python/cli/installation/

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
    1. open http://127.0.0.1:3000
    2. Click the hamburger icon at top right
    3. Select desired voice to use
    4. Input the IP Address of your node
    5. Input your node's Long Name
    6. Input Meshtastic CLI path (typically meshtastic)
    7. Input Max Text Length (229 is recommended)
    8. Input channel names that your node is on. (One channel name per line)
