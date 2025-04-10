# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module Arroba
  # HTTPClient is responsible for making HTTP requests to the atProto API.
  # It handles authentication and provides methods for GET and POST requests.
  class HTTPClient
    def initialize(identifier:, password:, base_url:, always_auth: false)
      @base_url = base_url
      @always_auth = always_auth
      authenticate!(identifier, password)
    end

    def get(url, query_params: nil, with_auth: true)
      uri = build_uri url, query_params
      request = Net::HTTP::Get.new(uri)
      authorize_request! request, with_auth

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request request
      end

      raise "Request failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end

    def post(url, body:, with_auth: true)
      uri = build_uri url
      request = Net::HTTP::Post.new(uri)
      authorize_request! request, with_auth
      response = json_request(uri, body, method: :post)
      raise "Request failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end

    # Explicitly defined to hide secrets in inspect output
    def inspect
      "#<Arroba::HTTPClient:0x#{object_id} @handle=#{@handle} @did=#{@did}>"
    end

    private

    def authenticate!(identifier, password)
      uri = build_uri '/xrpc/com.atproto.server.createSession'
      response = json_request(uri, { identifier: identifier, password: password })

      raise "Authentication failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      body = JSON.parse(response.body)
      @refresh_token = body['refreshJwt']
      @handle = body['handle']
      @did = body['did']
      @bearer_token = body['accessJwt']
    end

    def authorize_request!(request, with_auth)
      request['Authorization'] = "Bearer #{@bearer_token}" if @always_auth || with_auth
    end

    def json_request(url, body, method: :post)
      uri = URI(url)
      begin
        req_class = Object.const_get "Net::HTTP::#{method.capitalize}"
        request = req_class.new(uri)
        request['Content-Type'] = 'application/json'
        request.body = body.to_json
        make_request(uri) { |http| http.request request }
      rescue NameError
        raise ArgumentError, "Invalid HTTP method: #{method}"
      end
    end

    def make_request(uri, &)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https', &)
    end

    def build_uri(url, query_params = nil)
      uri = URI(@base_url + url)
      uri.query = URI.encode_www_form(query_params) unless query_params.nil?
      uri
    end
  end
end
