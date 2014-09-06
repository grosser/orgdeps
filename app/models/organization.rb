class Organization < ActiveRecord::Base
  serialize :repositories

  def to_s
    name
  end
end
