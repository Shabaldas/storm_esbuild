# frozen_string_literal: true

class TestJob
  include Sidekiq::Worker

  def perform
    puts 'I am , running my first job at'
  end
end
