$settings = YAML.load_file('settings.yml') rescue {}

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

$log_it = LogIt.new
$message_broadcaster = MessageBroadcaster.new
$message_processor = MessageProcessor.new.process
$message_receiver = MessageReceiver.new
$message_transmitter = MessageTransmitter.new
