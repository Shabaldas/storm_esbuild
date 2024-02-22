# frozen_string_literal: true

module DatabaseSeeds
  class Main
    def execute
      # Dummy
      DatabaseSeeds::Dummy::ProductCategoriesSeed.new.execute
      DatabaseSeeds::Dummy::OptionsSeed.new.execute
      DatabaseSeeds::Dummy::ProductOptionsSeed.new.execute
      DatabaseSeeds::Dummy::WorkersSeed.new.execute
      DatabaseSeeds::Dummy::ClientsSeed.new.execute
      DatabaseSeeds::Dummy::ManualOrdersSeed.new.execute
      DatabaseSeeds::Dummy::ProductsSeed.new.execute

      # Real
      DatabaseSeeds::Real::CitiesSeed.new.execute_frankivsk_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_lviv_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_ternopil_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_chernivtsi_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_rivne_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_volyn_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_zakarpattia_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_khmelnytskyi_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_vinnytsia_region_cities
      DatabaseSeeds::Real::CitiesSeed.new.execute_kyiv_region_cities
    end
  end
end
