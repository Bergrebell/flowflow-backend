# air_temp: grad celsius
# sun_time:     min, Zehnminutensumme(how many of the ten minutes are sunny)
# wind_speed:  km/h, Zehnminutenmittel
# rain_amount:   mm, Zehnminutensumme
# datetime: UTC (2h behind MESZ)
class WeatherMeasurement < ApplicationRecord
  validates_presence_of :number

  belongs_to :weather_station

  def as_json
    {
        'air_temp':   air_temp,
        'wind_speed': wind_speed,
        'indicator':  indicator,
        'datetime': datetime.in_time_zone('Zurich')
    }
  end

  private

  def indicator
    if rain_amount.between?(0, 1)
      if sun_time > 8
        'sun'
      elsif sun_time.between?(2, 8)
        'sun_cloud'
      else
        'cloud'
      end
    else
      'rain'
    end
  end
end
