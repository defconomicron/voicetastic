# https://cloud.google.com/speech-to-text/docs/samples?hl=en&language=ruby
# https://cloud.google.com/speech-to-text/docs/samples/speech-transcribe-sync?hl=en
# https://cloud.google.com/docs/authentication/set-up-adc-local-dev-environment
# gcloud init
# gcloud auth application-default login
# audio_file_path = "Path to file on which to perform speech recognition"

class VoiceToText
  def initialize(path)
    @path = path
  end

  def text
    require 'google/cloud/speech'
    speech = Google::Cloud::Speech.speech
    audio_file = File.binread @path
    config = {encoding: :MP3, sample_rate_hertz: 16_000, language_code: 'en-US'}
    audio = {content: audio_file}
    response = speech.recognize config: config, audio: audio
    results = response.results
    results.first.alternatives.first.transcript rescue nil
  end
end