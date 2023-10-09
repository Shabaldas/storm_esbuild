# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :seo_tags, only: :home

  def home
    @feedback_call = FeedbackCall.new
    
    set_meta_tags(
      title: "Інноваційні послуги 3D-друку в Івано-Франківську, Україна",
      description: "Перетворіть свої ідеї на реальність з передовими послугами 3D-друку. Високоякісні прототипи, моделі та більше в Івано-Франківську, Україна.",
      type: 'website',
      og: {
        title: "Інноваційні послуги 3D-друку в Івано-Франківську, Україна",
        description: "Перетворіть свої ідеї на реальність з передовими послугами 3D-друку. Високоякісні прототипи, моделі та більше в Івано-Франківську, Україна.",
        type: 'website',
        url: request.original_url
        # image: image_url('your_og_image.jpg') # Replace with your actual OG image URL
      }
    )
  end

  def save_phone_number
    @feedback_call = FeedbackCall.new(feedback_call_params)

    if @feedback_call.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :home
    end
  end

  private

  def feedback_call_params
    params.require(:feedback_call).permit(:phone_number)
  end

  def seo_tags
    set_meta_tags(
      title: t('static_pages.home.print_ideas_html'),
      description: t('static_pages.home.prototyping'),
      keywords: '3D Strom, 3D Друк, Івано-Франківськ 3Д друк',
      og: {
        title: t('static_pages.home.print_ideas_html'),
        description: t('static_pages.home.prototyping'),
        type: 'website',
        url: request.original_url,
        # image: image_url('your_og_image.jpg')
      }
    )
  end
end
