require 'yaml'
require 'city-state'

namespace :seed do

  desc "Import all countries"
  task :import_countries => :environment do
    CONN = ActiveRecord::Base.connection
    file = File.open(Rails.root + 'lib/data/worldcountries.txt')
    values = []
    file.each do |line|
      (code,name) = line.split(':')
      country_data = "(\'#{name.strip}\',\'#{code.downcase}\')"
      values << country_data
    end
    sql = "INSERT INTO countries (name, code) VALUES #{values.join(", ")}"
    CONN.execute sql
  end

  desc "Import all states"
  task :import_states => :environment do 
    CONN = ActiveRecord::Base.connection
    file = File.open(Rails.root + 'lib/data/worldstates.txt')
    values = []
    file.each do |line|
      (geoname_id,locale_code,continent_code,continent_name,country_iso_code,country_name,subdivision_1_iso_code,subdivision_1_name,subdivision_2_iso_code,subdivision_2_name,city_name,metro_code,time_zone) = line.split(',')
      next if country_iso_code.blank? || subdivision_1_name.blank?
      country =  Country.where(code: country_iso_code.downcase ).last
      values << "(\'#{subdivision_1_name.gsub("'","`")}\',\'#{country.id}\')"
    end
    sql = "INSERT INTO states (name, country_id) VALUES #{values.uniq.join(", ")}"
    CONN.execute sql
  end

  desc "Parsing gem and creating cities file"
  task :new_cities_file => :environment do
  hash = {}
  file = File.open(Rails.root + "lib/data/cities.yml", "a+")
    CS.countries.each do |country_code|
      next if country_code[0] == :COUNTRY_ISO_CODE
      country_code.each do |code|
        CS.states(code).each do |state|
          hash[state[1]] = []
          CS.cities(state[0],code).each do |city|
            hash[state[1]] << city 
          end
        end
      end
    end
  file << hash.to_yaml
  end

  desc "Import all cities"
  task :import_cities => :environment do
    CONN = ActiveRecord::Base.connection
    file = YAML.load_file(Rails.root + "lib/data/cities.yml")
    values = []
    file.each do |key, value|
      next if key.blank? || value.blank?
      key = key.gsub("'","`")
      state_id = State.where("name LIKE '%#{key}%'").last.id    
      country_id = State.where("name LIKE '%#{key}%'").last.country.id
      value.each do |city|
        city = city.gsub("'","`")
        city_data = "(\'#{city}\',\'#{country_id}\',\'#{state_id}\')"
        values << city_data
      end
    end
    sql = "INSERT INTO cities (name, country_id, state_id) VALUES #{values.uniq.join(", ")}"
    CONN.execute sql
  end

end