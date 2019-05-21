# frozen_string_literal: true

require 'spec_helper'
require 'api'

module Example::API
  RSpec.describe Serialization::Renderer do
    let(:renderer) { described_class }
    before do
      stub_const('FakeEntity', Struct.new(:id))
      stub_const('FakeSerializer', Class.new(JSONAPI::Serializable::Resource))
    end

    it 'renders as data when given a single non-error object' do
      allow(Serialization::Renderer).to receive(:data_renderers).and_return({
        FakeEntity: FakeSerializer,
      })
      expect(renderer.render(FakeEntity.new(1))).to eq({data: {id: '1', type: :unknown}})
    end

    it 'renders as data when given a collection of non-error objects' do
      allow(Serialization::Renderer).to receive(:data_renderers).and_return({
        FakeEntity: FakeSerializer,
      })
      expect(renderer.render([FakeEntity.new(1), FakeEntity.new(2)])).to eq({
        data: [
          {id: '1', type: :unknown},
          {id: '2', type: :unknown},
        ],
      })
    end

    it 'renders as errors when given a single error object' do
      error = Entities::Error.new
      expect(renderer.render([error])).to eq({
        errors: [
          {id: error.id},
        ],
      })
    end

    it 'renders as errors when given a collection of error objects' do
      errors = [Entities::Error.new, Entities::Error.new]
      expect(renderer.render(errors)).to eq({
        errors: [
          {id: errors[0].id},
          {id: errors[1].id},
        ],
      })
    end
  end
end
