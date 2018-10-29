# frozen_string_literal: true

# {
#   waterlevel: [{
#     value: 125, // aktueller wert
#     mean_24: 120,
#     datetime:
#   }, {}, {}, {}],
#   temperatur: []
# }
class HistoryService
  def initialize(station)
    @station = station
  end

  def call
    history
  end

  def history
    [%w[Temperature], %w[Discharge DischargeLiter], %w[Level SeaLevel]].map do |types|
      average = Measurement.where(type: types, datetime: (59.days.ago.to_date..Date.tomorrow), station: @station).average(:value).to_f
      next if average == 0.0

      {
        types.first.downcase.pluralize => { values: averages(types).to_a.map { |hash| hash.dig('average') }, average: average }
      }
    end.compact.reduce({}) { |hash, measurements| hash.merge(measurements) }
  end

  private

  def averages(types)
    query = <<-SQL
      SELECT
        TIMESTAMP WITH TIME ZONE 'epoch' + INTERVAL '1 second' * round(extract('epoch' FROM datetime) / 259200) * 259200 AS timestamp,
        avg(value) AS average
      FROM measurements
      WHERE type IN (#{types.map { |type| "'#{type}'" }.join(', ')}) AND station_id = #{@station.id}
      GROUP BY round(extract('epoch' FROM datetime) / 259200)
      ORDER BY timestamp
    SQL

    ActiveRecord::Base.connection.execute(query)
  end

  def weekly_average(m)
    @station.send(m).less_than_week_old.average(:value).to_f
  end
end
