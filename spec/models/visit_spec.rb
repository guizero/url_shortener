# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visit, type: :model do
  subject { described_class.create(ip: '215.215.215.215', short_url_id: 1) }

  it { should belong_to(:short_url) }
  it { should validate_uniqueness_of(:ip).scoped_to(:short_url_id).case_insensitive }
  it { should validate_presence_of(:ip) }
end
