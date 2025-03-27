require 'openai'

class Captain::Llm::EmbeddingService < Llm::BaseOpenAiService
  class EmbeddingsError < StandardError; end

  # text-embedding-ada-002 provides 1024 dimensions
  DEFAULT_MODEL = 'text-embedding-ada-002'.freeze

  def get_embedding(content, model: DEFAULT_MODEL)
    response = @client.embeddings(
      parameters: {
        model: model,
        input: content
      }
    )

    response.dig('data', 0, 'embedding')
  rescue StandardError => e
    raise EmbeddingsError, "Failed to create an embedding: #{e.message}"
  end
end
