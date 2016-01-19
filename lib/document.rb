require 'json'
require 'net/http/post/multipart'

class Document
  attr_reader :data

  def initialize(doc)
    @data = get_doc(doc)
  end

  private

  def get_doc
    uri = URI("https://gateway.watsonplatform.net/document-conversion/api/v1/convert_document?version=2015-12-15")

  end
end

curl -u "6215eb69-4b15-4a95-857d-5e77cd610da9":"nidHwTSGSM3j" \
-F 'config={"conversion_target":"ANSWER_UNITS"}' \
-F 'file=@sample.pdf' \
"https://gateway.watsonplatform.net/document-conversion/api/v1/convert_document?version=2015-12-15"
