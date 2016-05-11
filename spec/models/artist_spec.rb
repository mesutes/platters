require "rails_helper"

RSpec.describe Artist, type: :model do
  context "naming" do
    let!(:artist) { FactoryGirl.create(:artist) }

    it "successfully" do
      expect(artist.errors.messages.any?).to be_falsy
      expect(Artist.first.name).to eq "ABC"
    end

    it "must be unique" do
      artist = Artist.create(name: "ABC")
      expect(artist.errors.messages.any?).to be_truthy
      expect(artist.errors.messages[:name].first).to eq "has already been taken"
    end

    it "must be case-insensitive unique" do
      artist = Artist.create(name: "aBc")
      expect(artist.errors.messages.any?).to be_truthy
      expect(artist.errors.messages[:name].first).to eq "has already been taken"
    end
  end
end
