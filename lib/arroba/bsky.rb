# frozen_string_literal: true

require_relative 'bsky/actor'
require_relative 'bsky/feed'
require_relative 'bsky/graph'

module Arroba
  # This class provides access to various resources such as Actor, Feed, Graph, Labeler, Notification, and Video
  #
  # @see Arroba::BSky::Actor
  # @see Arroba::BSky::Feed
  # @see Arroba::BSky::Graph
  # @see Arroba::BSky::Labeler
  # @see Arroba::BSky::Notification
  # @see Arroba::BSky::Video
  class BSky
    def initialize(client)
      @client = client
    end

    def actor = @actor ||= Actor.new(@client)
    def feed = @feed ||= Feed.new(@client)
    def graph = @graph ||= Graph.new(@client)
  end
end
