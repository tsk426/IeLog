class EstimateTag < ApplicationRecord
  belongs_to :estimate
  belongs_to :tag
end
