require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  #attr_accessor :id, :name, :breed

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true
    sql = "pragma table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    column_names = []
    table_info.each do |col|
      column_names << col["name"]
    end
    column_names.compact
  end

  def initialize(options = {})
    options.each do |prop, value|
      self.send("#{prop}=", value)
    end
  end

  def table_name_for_insert
    self.class.to_s.downcase.pluralize
  end

end
