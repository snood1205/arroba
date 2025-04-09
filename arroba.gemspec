# frozen_string_literal: true

require_relative 'lib/arroba/version'

Gem::Specification.new do |spec|
  spec.name = 'arroba'
  spec.version = Arroba::VERSION
  spec.authors = %w[Eli]
  spec.email = '9064062+snood1205@users.noreply.github.com'

  spec.summary = 'An unofficial Ruby client for ATProto'
  spec.homepage = 'https://github.com/snood1205/arroba'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ spec/ .git .github Gemfile])
    end
  end

  spec.require_paths = ['lib']
end
