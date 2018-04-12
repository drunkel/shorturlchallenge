require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  it 'is not valid without an original_url' do
    expect(ShortUrl.new(short_url: '1234')).to_not be_valid
  end

  it 'is not valid when short_url is not exactly 4 characters' do
    expect(ShortUrl.new(original_url: 'test.com', short_url: '12345')).to_not be_valid
    expect(ShortUrl.new(original_url: 'test@test.com', short_url: '123')).to_not be_valid
  end

  it 'generates a 4 character short_url on save' do
    short_url = ShortUrl.new(original_url: 'test@test.com')
    short_url.save
    short_url.reload
    expect(short_url.short_url).to_not be_nil
    expect(short_url.short_url.length).to eql 4
  end
end
