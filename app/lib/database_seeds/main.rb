# frozen_string_literal: true

module DatabaseSeeds
  class Main
    def execute
      # Dummy
      DatabaseSeeds::Dummy::ProductCategoriesSeed.new.execute
      DatabaseSeeds::Dummy::ProductsSeed.new.execute
      DatabaseSeeds::Dummy::OptionsSeed.new.execute
      DatabaseSeeds::Dummy::ProductOptionsSeed.new.execute

      # Real
      DatabaseSeeds::Real::CitiesSeed.new.execute_frankivsk_region_cities
    end
  end
end
