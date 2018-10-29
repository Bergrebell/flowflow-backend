# frozen_string_literal: true

# {
#     "temperatures": {
#         "values": [
#             15.0,
#             20.3333333333333,
#             24.0,
#              ...
#         ],
#         "average": 22.4285714285714
#     }, 

class HistoryService
  def initialize(station)
    @station = station
  end

  def call
    history
  end

  def history
    ["Temperature", "Discharge", "DischargeLiter", "Level", "SeaLevel"].map do |type|
      average = Measurement.where(type: type, datetime: (59.days.ago.to_date..Date.tomorrow), station: @station).average(:value).to_f
      next if average == 0.0

      {
        type.downcase.pluralize => { values: averages(type).to_a.map { |hash| hash.dig('average') }, average: average }
      }
    end.compact.reduce({}) { |hash, measurements| hash.merge(measurements) }
  end

  private

  def averages(measurement_type)
    query = <<-SQL
      SELECT
        TIMESTAMP WITH TIME ZONE 'epoch' + INTERVAL '1 second' * round(extract('epoch' FROM datetime) / 259200) * 259200 AS timestamp,
        avg(value) AS average
      FROM measurements
      WHERE type = '#{measurement_type}' AND station_id = #{@station.id} AND datetime >= '#{59.days.ago.to_date}'
      GROUP BY round(extract('epoch' FROM datetime) / 259200)
      ORDER BY timestamp
    SQL

    ActiveRecord::Base.connection.execute(query)
  end

  def weekly_average(m)
    @station.send(m).less_than_week_old.average(:value).to_f
  end
end
