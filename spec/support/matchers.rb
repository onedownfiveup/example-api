# frozen_string_literal: true

RSpec::Matchers.define(:be_uuid) do
  uuid_regex = /\A[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}\z/
  match do |actual|
    actual =~ uuid_regex
  end
end

RSpec::Matchers.define(:be_valid_time_string) do
  match do |actual|
    begin
      Time.parse(actual)
      true
    rescue ArgumentError
      false
    end
  end
end
