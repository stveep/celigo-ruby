require "celigo/version"
require "celigo/confluence"

module Celigo

  class << self
    attr_accessor :sep
  end
  @sep = "\t"

  def self.remove_percentage(string)
    string.sub("%","").to_f
  end

  def self.to_symbol(string)
    string.gsub(" ","_").downcase.to_sym
  end

  def output_table(method)
    array_of_arrays = self.send(method)
    array_of_arrays.each do |row|
      puts row.join(Celigo.sep)
    end
  end


  def output_list(method)
    array_of_arrays = self.send(method)
    letters = [*"A".."Z"]
    array_of_arrays.each_with_index do |row, i|
      i = letters[i]
      row.each_with_index do |element, j|
        j = j+1
        element ||= "" # in case of nil
        if block_given?
          annotation = yield(i,j)
        else
          annotation = i.to_s + j.to_s
        end
        puts ([annotation, element]).join(Celigo.sep)
      end
    end
  end
end
