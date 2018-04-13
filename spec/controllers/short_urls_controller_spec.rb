require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do

  let(:test_url) { 'http://test.com' }

  describe '#show' do
    subject { get :show, params: { short_url: short_url_param } }

    context 'when the short_url provided exists' do
      let!(:short_url) { ShortUrl.create!(original_url: test_url) }
      let(:short_url_param) { short_url.short_url }

      it 'redirects the user to the original_url' do
        subject
        expect(response).to redirect_to(short_url.original_url)
      end
    end

    context 'when the short_url provided does NOT exist' do
      let(:short_url_param) { 'lolgoodtry' }

      it 'returns a 404' do
        subject
        expect(response.status).to eql 404
      end
    end
  end

  describe '#create' do
    subject { post :create, params: { url: test_url } }

    it 'Sends the url to the persistence service' do
      expect_any_instance_of(ShortUrlPersistenceService).to receive(:initialize).with(test_url)
      subject
    end
  end
end
