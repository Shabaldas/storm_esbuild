# frozen_string_literal: true

module GoogleAnalyticsHelper
  def google_analytics_head_script
    return unless Rails.env.production?

    javascript_tag nonce: true do
      <<-JAVASCRIPT.html_safe
        (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','G-QMC1QVF8BG');
      JAVASCRIPT
    end
  end

  def google_analytics_tag_head_script
    return unless Rails.env.production?

    javascript_tag nonce: true do
      <<-JAVASCRIPT.html_safe
        (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-NGCRPTL');
      JAVASCRIPT
    end
  end

  def google_analytics_tag_body_script
    return unless Rails.env.production?

    '<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NGCRPTL" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>'.html_safe # rubocop:disable Layout/LineLength
  end
end
