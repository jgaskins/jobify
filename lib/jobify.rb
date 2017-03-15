require 'jobify/version'

module Jobify
  module_function

  # Deserialize a list of opportunities from an input string
  #
  # @param string [String] Lines of comma-separated fields for an Opportunity
  # @return [Array<Opportunity>] List of opportunities specified by the string
  def from_string(string)
    string.split(/\n/).map do |line|
      Opportunity.new(*line.split(',').map(&:strip))
    end
  end

  # Serialize a list of opportunities to a human-readable string. Includes a
  # final newline because it's human-friendly.
  #
  # @param jobs [Array<Opportunity>] the list of opportunities to serialize
  # @return [String] the string for human consumption
  def report(jobs)
    # <Most Interesting Man in the World>
    # I don't always write method chains, but when I do, they're Enumerable
    # calls or ActiveRecord scopes and they're arranged to look like an Elixir
    # pipeline.
    jobs
      .sort_by(&:title)
      .each_with_object("All Opportunities\n") do |job, string|
        string << job.to_s << "\n"
      end
  end

  # Ordinarily, this would go into its own file, but it's small enough to keep
  # in the main library file. If it had a lot of its own logic, I'd extract it.
  class Opportunity
    attr_reader :title, :organization, :min, :max

    def initialize(title, organization, city, state, min, max)
      @title = title
      @organization = organization
      @city = city
      @state = state
      @min = min.to_i
      @max = max.to_i
    end

    def location
      "#@city, #@state"
    end

    def to_s
      "Title: #@title, Organization: #@organization, Location: #{location}, Pay: #@min-#@max"
    end
  end
end
