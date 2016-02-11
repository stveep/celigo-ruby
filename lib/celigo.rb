require "celigo/version"
require "celigo/confluence"

module Celigo
  def self.remove_percentage(string)
    string.sub("%","").to_f
  end

  def self.to_symbol(string)
    string.gsub(" ","_").downcase.to_sym
  end
end
