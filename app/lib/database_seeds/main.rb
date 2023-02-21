# frozen_string_literal: true

module DatabaseSeeds
  class Main
    def execute
      DatabaseSeeds::Dummy::ProductCategoriesSeed.new.execute
      DatabaseSeeds::Dummy::ProductsSeed.new.execute
      DatabaseSeeds::Dummy::OptionsSeed.new.execute
      DatabaseSeeds::Dummy::ProductOptionsSeed.new.execute
    end
  end
end
