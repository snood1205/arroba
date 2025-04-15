# frozen_string_literal: true

require_relative 'bsky/actor'
require_relative 'bsky/feed'
require_relative 'bsky/graph'
require_relative 'bsky/labeler'
require_relative 'bsky/notification'
require_relative 'bsky/video'

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
    def labeler = @labeler ||= Labeler.new(@client)
    def notification = @notification ||= Notification.new(@client)
    def video = @video ||= Video.new(@client)
  end
end
