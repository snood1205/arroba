# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module Arroba
  # HTTPClient is responsible for making HTTP requests to the atProto API.
  # It handles authentication and provides methods for GET and POST requests.
  class HTTPClient
    def initialize(identifier:, password:, auth_url:, always_auth: false)
      @always_auth = always_auth
      authenticate!(auth_url, identifier, password)
    end

    def get(url, query_params: nil, with_auth: true)
      uri = build_uri url, query_params
      request = request_object(:get, uri, with_auth:)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request request
      end

      raise "Request failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end

    def post(url, body:, with_auth: true)
      uri = build_uri url
      response = json_request(uri, body, method: :post, with_auth:)
      raise "Request failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      if response.body.empty?
        response.message
      else
        JSON.parse(response.body)
      end
    rescue JSON::ParserError
      puts response.body
    end

    # Explicitly defined to hide secrets in inspect output
    def inspect
      "#<Arroba::HTTPClient:0x#{object_id} @handle=#{@handle} @did=#{@did}>"
    end

    def proxy_for_chat!
      @atproto_proxy = 'did:web:api.bsky.chat#bsky_chat'
      @proxy_check = 'chat'
    end

    private

    def authenticate!(auth_url, identifier, password)
      uri = URI("#{auth_url}/xrpc/com.atproto.server.createSession")
      response = json_request(uri, { identifier: identifier, password: password })

      raise "Authentication failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      body = JSON.parse(response.body)
      @base_url = body['didDoc']['service'][0]['serviceEndpoint']
      @refresh_token = body['refreshJwt']
      @handle = body['handle']
      @did = body['did']
      @bearer_token = body['accessJwt']
    end

    def authorize_request!(request, with_auth)
      request['Authorization'] = "Bearer #{@bearer_token}" if @always_auth || with_auth
    end

    def proxy_request!(request, uri)
      return if @atproto_proxy.nil? || !uri.to_s.include?(@proxy_check)

      request['atproto-proxy'] = @atproto_proxy
    end

    def json_request(url, body, method: :post, with_auth: false)
      uri = URI(url)
      begin
        request = request_object(method, uri, with_auth:)
        request['Content-Type'] = 'application/json'
        request.body = body.to_json
        make_request(uri) { |http| http.request request }
      rescue NameError
        raise ArgumentError, "Invalid HTTP method: #{method}"
      end
    end

    def request_object(method, uri, with_auth:)
      req_class = Object.const_get "Net::HTTP::#{method.capitalize}"
      request = req_class.new(uri)
      authorize_request! request, with_auth
      proxy_request! request, uri
      request
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
