require 'csv'

class Celigo::Confluence
  include Celigo

  class << self
    attr_accessor :maps_heading, :settings, :types
  end
  @maps_heading = "Measurement Plate Maps"
  @settings = /\AAnalysis Settings\z/
  @types = {/\A24/ => :well24,
            /\A96/ => :well96,
            /\A6/ => :well6,
            /\A12/ => :well12,
            /\A384/ => :well384}

  def initialize(file)
    maps = false
    settings = nil
    @settings = Hash.new{|h,k| h[k] = {}}
    @metadata = {}
    @maps = Hash.new{|h,k| h[k] = []}
    title = ""
    CSV.foreach(file) do |line|
      next unless first = line.shift
      if first.match Celigo::Confluence.settings
        maps == false
        if settings == nil # First settings line
          settings = first
          next
        elsif settings = Celigo::Confluence.settings
          key = settings
          settings
        end
        # TO DO



      end
      if first == Celigo::Confluence.maps_heading || maps == true
        if maps == false
          maps = true
          next
        end
        unless first.match /\A[A-Z]{,2}\z/
          title = Celigo.to_symbol first.sub(" (%)","")
          next
        end
        @maps[title] << line

      end
      @metadata[first] = single_value(line) unless maps
    end
    process_maps
  end

  def process_maps
    dmaps = @maps.dup
    dmaps.each do |key, array|
      max = array.max_by{|a| a.size}.size
      array.map!{|row| row.map!{|row2| Celigo.remove_percentage(row2) if row2}}
      array.map!{|row| row == [nil] ? row = Array.new(max) : row}
    end
    @maps = dmaps
    self
  end

  def confluency
    @maps[:confluency]
  end

  def sampling
    @maps[:well_sampled]
  end

  def type
    type = nil
    Celigo::Confluence.types.each do |k,v|
      if self.plate.match k
        type ||= v
      end
    end
    type
  end

  def plate
    @metadata["Plate Type"]
  end


  def single_value(line)
    line.size == 1 ? line[0] : line
  end
end
