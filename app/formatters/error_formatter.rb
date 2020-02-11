class ErrorFormatter
  def self.call(*args)
    new.call(*args)
  end

  def call(status: :unprocessable_entity, errors: {}, error: {})
    list_of_errors = {
      errors: errors.presence || process_single_error(error)
    }

    {
      json: list_of_errors,
      status: status
    }
  end

  private

  def process_single_error(error)
    error.map { |k, v| [ k, [v] ] }.to_h
  end
end