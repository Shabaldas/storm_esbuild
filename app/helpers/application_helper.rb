# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  COLORS = ['FFFFFF', 'E9646B', 'F1C232', '202020', '96E06C', '67ACEC', '5e36a2'].freeze
  MATERIALS = ['PLA', 'ABS', 'PET', 'PC', 'Nylon', 'Elastan', 'TPU', 'Phrozen Sonic Aqua 4k'].freeze
  QUALITY = [100, 200, 300].freeze

  def inline_error_for(field, form_obj)
    return ''.html_safe unless form_obj.errors[field].any?

    html = []
    html << tag.div(form_obj.errors[field][0].capitalize, class: 'text-red-400 text-xs m-0 p-0 text-left mb-2')
    html.join.html_safe
  end

  def current_locale?(locale)
    I18n.locale == locale
  end

  def locale_switcher(locale, flag_path)
    if current_locale?(locale)
      content_tag(:div, class: 'flex w-6 h-6 p-0 justify-center items-center cursor-not-allowed') do
        image_tag(flag_path, class: ('opacity-40' if current_locale?(locale)).to_s)
      end
    else
      button_to locale_path(locale), method: :put, data: { turbo: false }, class: 'pt-1' do
        content_tag(:div, class: 'flex w-6 h-6 p-0 justify-center items-center') do
          image_tag(flag_path, class: ('opacity-40' if current_locale?(locale)).to_s)
        end
      end
    end
  end

  def order_status_icon(order)
    if order.paid?
      'done_icon'
    else
      'not_done_icon'
    end
  end

  def order_accepted_files(order_name)
    case order_name.to_s
    when 'printing'
      '.obj,.stl,.zip,.rar,.7z'
    when 'modeling'
      '.pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png,.zip,.rar,.7z'
    else
      '.pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png,.obj,.stl,.step,.stp,.iges,.igs,.sldprt,.sldasm,.prt,.asm,.x_t,.x_b,.xmt_txt,.xmt_bin,.zip,.rar,.7z'
    end
  end
end
