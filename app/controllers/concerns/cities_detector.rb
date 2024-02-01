# frozen_string_literal: true

module CitiesDetector
  def detect_city(city_params)
    return if city_params.blank?

    input_city_name = city_params.downcase
    all_english_names = City.pluck(:english_name).map(&:downcase)
    all_ukrainian_names = City.pluck(:ukrainian_name).map(&:downcase)

    english_matcher = FuzzyMatch.new(all_english_names)
    ukrainian_matcher = FuzzyMatch.new(all_ukrainian_names)
    closest_english_match = english_matcher.find(input_city_name)
    closest_ukrainian_match = ukrainian_matcher.find(input_city_name)

    final_match = closest_english_match || closest_ukrainian_match

    if final_match.present?
      @city = City.find_by('lower(english_name) = ? OR lower(ukrainian_name) = ?', final_match.downcase, final_match.downcase)
    else
      redirect_to printing_path
    end
  end
end
