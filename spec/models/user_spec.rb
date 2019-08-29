require 'rails_helper'

describe User, type: :model do

  describe "relationships" do
    it {should belong_to(:merchant).optional}
  end
end
