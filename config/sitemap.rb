# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://3dstorm.com.ua/'

SitemapGenerator::Sitemap.create do
  add '/printing', changefreq: 'weekly', priority: 0.9
  add '/rendering', changefreq: 'weekly', priority: 0.9
  add '/modeling', changefreq: 'weekly', priority: 0.9

  City.find_each do |city|
    add printing_city_path(city.english_name.downcase), lastmod: city.updated_at, priority: 0.8
    add printing_city_path(city.ukrainian_name.downcase), lastmod: city.updated_at, priority: 0.8
    add rendering_city_path(city.english_name.downcase), lastmod: city.updated_at, priority: 0.7
    add rendering_city_path(city.ukrainian_name.downcase), lastmod: city.updated_at, priority: 0.7
    add modeling_city_path(city.english_name.downcase), lastmod: city.updated_at, priority: 0.7
    add modeling_city_path(city.ukrainian_name.downcase), lastmod: city.updated_at, priority: 0.7
  end

  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
