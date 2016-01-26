class Programmer < ActiveRecord::Base
  def attributes_for_partial
    ['home_country', 'quote', 'claim_to_fame']
  end

  def locals_hash
    attributes_for_partial.each_with_object({}) do |att, hash|
      hash[att] = attributes[att]
    end
  end
end
