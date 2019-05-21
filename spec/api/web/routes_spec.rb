# frozen_string_literal: true

require 'spec_helper'

module Example::API
  RSpec.describe Web::Routes do
    describe '#path_for' do
      it 'gives path excluding base path for the given route' do
        url = Web::Routes.path_for('health_check')
        expect(url).to eq '/health_check'
      end

      it 'raises an error for unknown routes' do
        expect do
          Web::Routes.path_for('not_a_teapot')
        end.to raise_error(/not a known path/)
      end
    end

    describe '#url_for' do
      it 'gives full URL including base path for the given route' do
        allow(Web).to receive(:base_url).and_return('http://example.com/foo')
        url = Web::Routes.url_for('health_check')
        expect(url).to eq 'http://example.com/foo/health_check'
      end
    end
  end
end
