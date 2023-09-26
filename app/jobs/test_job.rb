# frozen_string_literal: true

# rubocop:disable Rails/Output
class TestJob
  include Sidekiq::Worker

  def perform
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    puts 'I am , running my first job at'
    puts 'I am , running my first job at'
    puts 'I am , running my first job at'
    puts 'I am , running my first job at'
    puts 'I am , running my first job at'
    puts 'I am , running my first job at'
    puts '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
  end
end
# rubocop:enable Rails/Output
