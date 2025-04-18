# gcloud auth login
# gcloud config set project astute-charter-455419-r3
# gcloud init
# gcloud auth application-default login
# https://cloud.google.com/text-to-speech/docs/create-audio#text-to-speech-text-additional-langs

class TextToVoice
  def initialize(text)
    @text = text
  end

  def voice
    if true
      response = `curl -X POST -H "Content-Type: application/json" \
      -H "X-Goog-User-Project: $(gcloud config list --format='value(core.project)')" \
      -H "Authorization: Bearer $(gcloud auth print-access-token)" \
      --data '{
      "input": {
        "text": "#{@text}"
      },
      "voice": {
        "languageCode": "en-US",
        "name": "en-US-Chirp3-HD-#{google_voice}"
      },
      "audioConfig": {
        "audioEncoding": "MP3"
      }
      }' "https://texttospeech.googleapis.com/v1/text:synthesize"`
      response = JSON.parse(response)
      error = response['error']['message'] rescue nil
      broadcast("ERROR: #{error}") if error.present?
      require 'base64'
      File.write('public/output.mp3', Base64.decode64(response['audioContent']), mode: 'wb')
    else
      speech = ESpeak::Speech.new(@text, voice: 'en-us')
      speech.save('public/output.mp3')
    end
    "<audio controls autoplay style='width:100%;margin-top:1em'><source src=\"output.mp3?no_cache=#{Time.now.to_i}\" type=\"audio/mp3\"></audio>"
  end

  private

    def google_voice
      Variable.where(name: 'google_voice').first_or_initialize.value
    end

    def broadcast(str)
      $message_broadcaster.broadcast(message: str)
    end
end