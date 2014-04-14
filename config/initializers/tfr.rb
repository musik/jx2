ThemesForRails.config do |config|
  # themes_dir is used to allow ThemesForRails to list available themes. It is not used to resolve any paths or routes.
  config.themes_dir = ":root/app/assets/themes"

  # assets_dir is the path to your theme assets.
  config.assets_dir = ":root/app/assets/themes/:name"

  # views_dir is the path to your theme views
  config.views_dir =  ":root/app/views/themes/:name"

  config.themes_routes_dir = "assets"
end
