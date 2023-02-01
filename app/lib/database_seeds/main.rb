# frozen_string_literal: true

module DatabaseSeeds
  class Main
    def execute
      DatabaseSeeds::Dummy::ProductCategoriesSeed.new.execute
    end
  end
end
